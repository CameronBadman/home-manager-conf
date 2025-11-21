{ config, pkgs, ... }:

{
  xdg.configFile."pipewire/pipewire.conf.d/92-yeti-x.conf".text = ''
    rules = [
      {
        matches = [
          {
            "device.nick" = "Yeti X"
          }
        ]
        actions = {
          update-props = {
            "api.alsa.use-acp" = false
            "device.profile-set" = "default"
          }
        }
      }
    ]
  '';
}
