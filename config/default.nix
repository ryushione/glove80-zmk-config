{ pkgs ?  import <nixpkgs> {}
, firmware ? import ../src {}
}:

let
  config = ./.;

  # Only the central (left) half gets the Studio USB-serial transport.
  # The peripheral (right) receives keymap updates over the BLE inter-half link.
  glove80_left  = firmware.zmk.override { board = "glove80_lh"; keymap = "${config}/glove80.keymap"; kconfig = "${config}/glove80.conf"; snippets = [ "studio-rpc-usb-uart" ]; };
  glove80_right = firmware.zmk.override { board = "glove80_rh"; keymap = "${config}/glove80.keymap"; kconfig = "${config}/glove80.conf"; };

in firmware.combine_uf2 glove80_left glove80_right
