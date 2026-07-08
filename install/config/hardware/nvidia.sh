if lspci | grep -qi 'nvidia'; then
  # Check which kernel is installed and set appropriate headers package
  KERNEL_HEADERS="$(pacman -Qqs '^linux(-zen|-lts|-hardened)?$' | head -1)-headers"

  if omarchy-hw-nvidia-gsp; then
    PACKAGES=(nvidia-open-dkms nvidia-utils libva-nvidia-driver)
  fi

  # Bail if no supported GPU
  if [[ -z ${PACKAGES+x} ]]; then
    echo "No compatible driver for your NVIDIA GPU. See: https://wiki.archlinux.org/title/NVIDIA"
    exit 0
  fi

  omarchy-pkg-add "$KERNEL_HEADERS" "${PACKAGES[@]}"

  # Configure modprobe for early KMS
  sudo tee /etc/modprobe.d/nvidia.conf <<EOF >/dev/null
options nvidia_drm modeset=1
EOF

  # Configure mkinitcpio for early loading
  sudo tee /etc/mkinitcpio.conf.d/nvidia.conf <<EOF >/dev/null
MODULES+=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
EOF

  cat >>"$HOME/.config/hypr/envs.lua" <<'EOF'

-- NVIDIA (Turing+ with GSP firmware)
hl.env("NVD_BACKEND", "direct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
EOF
fi
