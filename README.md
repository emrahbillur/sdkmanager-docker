# Ubuntu 20.04 LTS based NVIDIA SDK Manager container for flashing Orin Devices
sdkmanager runs as graphical interface. 
after running container.

- Just run 
  `make image`
to build the docker image
- and 
  `make run`
to execute the sdkmanager docker.

If the docker fails to create the flash image just run in the docker command line this command `update-binfmts --enable qemu-aarch64`

Manual command for flashing 5.1.4 Jetpack
sdkmanager --cli --action install --login-type devzone --product Jetson --target-os Linux --version 5.1.4 --show-all-versions --host --target JETSON_AGX_ORIN_TARGETS --select 'Jetson SDK Components' --deselect 'Developer Tools' --flash --license accept

