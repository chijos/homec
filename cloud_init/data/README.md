# cloud_init/data

The data files here are served over a basic HTTP file server to act as the data source for cloud-init.

On first boot, cloud-init will trigger on the target machine and reach out to pull the below three files:

- [http://cloud-init-server:8080/cloud-init/user-data](http://cloud-init-server:8080/cloud-init/user-data)
  Copy the user-data.example file into a user-data file (ignored by git already). See cloud-init reference documentation for what can be added in here: user creation, installing SSH keys, running ad-hoc shell commands, etc.
  The user-data file is part of [.gitignore](./.gitignore) because it is likely to contain sensitive information. **Keep it this way - do not check it in.**

- [http://cloud-init-server:8080/cloud-init/vendor-data](http://cloud-init-server:8080/cloud-init/vendor-data)
  Usually supplied by the cloud vendor (think AWS, GCP, Azure, etc.). I'm not intending to use it here, so it just has the required `#cloud-config` header. The file needs to exist even if it is not used.
  
- [http://cloud-init-server:8080/cloud-init/meta-data](http://cloud-init-server:8080/cloud-init/meta-data)
  Meta-data for the instance of the image. I don't expect to put anything sensitive in here, so the actual file is checked in.
