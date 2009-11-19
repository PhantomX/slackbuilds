/*
 * k10temp.c - Linux kernel module for hardware monitoring
 *
 * Copyright (C) 2008 Rudolf Marek <r.marek@assembler.cz>
 *
 * Inspired from the k8temp driver.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 */

#include <linux/module.h>
#include <linux/delay.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/jiffies.h>
#include <linux/pci.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>

/* 1000 / 8 = 125 no mask because we shift from bit 31 */
#define TEMP_FROM_REG(val)	(((val) >> 21) * 125)
#define REG_TEMP	0xa4

struct k10temp_data {
	struct device *hwmon_dev;
	struct mutex update_lock;
	const char *name;
	char valid;		/* zero until following fields are valid */
	unsigned long last_updated;	/* in jiffies */

	/* registers values */
	u32 temp;		/* raw value */
};

static struct k10temp_data *k10temp_update_device(struct device *dev)
{
	struct k10temp_data *data = dev_get_drvdata(dev);
	struct pci_dev *pdev = to_pci_dev(dev);
	u8 tmp;

	mutex_lock(&data->update_lock);

	if (!data->valid
	    || time_after(jiffies, data->last_updated + HZ)) {


		pci_read_config_dword(pdev, REG_TEMP, &data->temp);

		data->last_updated = jiffies;
		data->valid = 1;
	}

	mutex_unlock(&data->update_lock);
	return data;
}

/*
 * Sysfs stuff
 */

static ssize_t show_name(struct device *dev, struct device_attribute
			 *devattr, char *buf)
{
	struct k10temp_data *data = dev_get_drvdata(dev);

	return sprintf(buf, "%s\n", data->name);
}


static ssize_t show_temp(struct device *dev,
			 struct device_attribute *devattr, char *buf)
{
	struct sensor_device_attribute_2 *attr =
	    to_sensor_dev_attr_2(devattr);
	int core = attr->nr;
	int place = attr->index;
	struct k10temp_data *data = k10temp_update_device(dev);

	return sprintf(buf, "%d\n",
		       TEMP_FROM_REG(data->temp));
}

/* core, place */

static SENSOR_DEVICE_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0);
static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);

static struct pci_device_id k10temp_ids[] = {
	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1203) },
	{ 0 },
};

MODULE_DEVICE_TABLE(pci, k10temp_ids);

static int __devinit k10temp_probe(struct pci_dev *pdev,
				  const struct pci_device_id *id)
{
	int err;
	u8 scfg;
	u32 temp;
	struct k10temp_data *data;

	if (!(data = kzalloc(sizeof(struct k10temp_data), GFP_KERNEL))) {
		err = -ENOMEM;
		goto exit;
	}

	data->name = "k10temp";
	mutex_init(&data->update_lock);
	dev_set_drvdata(&pdev->dev, data);

	/* Register sysfs hooks */
	err = device_create_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	if (err)
		goto exit_remove;

	err = device_create_file(&pdev->dev, &dev_attr_name);
	if (err)
		goto exit_remove;

	data->hwmon_dev = hwmon_device_register(&pdev->dev);

	if (IS_ERR(data->hwmon_dev)) {
		err = PTR_ERR(data->hwmon_dev);
		goto exit_remove;
	}

	return 0;

exit_remove:
	device_remove_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	device_remove_file(&pdev->dev, &dev_attr_name);
exit_free:
	dev_set_drvdata(&pdev->dev, NULL);
	kfree(data);
exit:
	return err;
}

static void __devexit k10temp_remove(struct pci_dev *pdev)
{
	struct k10temp_data *data = dev_get_drvdata(&pdev->dev);

	hwmon_device_unregister(data->hwmon_dev);
	device_remove_file(&pdev->dev,
			   &sensor_dev_attr_temp1_input.dev_attr);
	device_remove_file(&pdev->dev, &dev_attr_name);
	dev_set_drvdata(&pdev->dev, NULL);
	kfree(data);
}

static struct pci_driver k10temp_driver = {
	.name = "k10temp",
	.id_table = k10temp_ids,
	.probe = k10temp_probe,
	.remove = __devexit_p(k10temp_remove),
};

static int __init k10temp_init(void)
{
	return pci_register_driver(&k10temp_driver);
}

static void __exit k10temp_exit(void)
{
	pci_unregister_driver(&k10temp_driver);
}

MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
MODULE_DESCRIPTION("AMD K10 core temperature monitor");
MODULE_LICENSE("GPL");

module_init(k10temp_init)
module_exit(k10temp_exit)
