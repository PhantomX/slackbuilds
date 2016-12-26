#include "vl_decoder.h"
bool
vl_profile_supported(struct pipe_screen *screen, enum pipe_video_profile profile,
                     enum pipe_video_entrypoint entrypoint)
{
   return false;
}

int
vl_level_supported(struct pipe_screen *screen, enum pipe_video_profile profile)
{
   return 0;
}

struct pipe_video_codec *
vl_create_decoder(struct pipe_context *pipe,
                  const struct pipe_video_codec *templat)
{
   return NULL;
}
