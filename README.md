# Metasploitable 3 (Windows)

[Metasploitable 3](https://github.com/rapid7/metasploitable3) by Rapid7: an intentionally
vulnerable server for practising exploitation. This repository runs its Windows Server 2008 R2
machine with [Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml) describes the
machine. Like upstream's own [Vagrantfile](metasploitable3/Vagrantfile), it runs Rapid7's
published box `rapid7/metasploitable3-win2k8` (built by Rapid7 from the Packer template and
scripts vendored in [`metasploitable3/`](metasploitable3)), then upstream's first-boot steps at
the default difficulty ([`provision/startup.ps1`](provision/startup.ps1)): firewall on with the
vulnerable services opened, the autorun mapping the Linux machine's share, scripts removed.

| Machine | Services |
| --- | --- |
| win2k8 | FTP 21, SSH 22, IIS 80, GlassFish 4848 and 8080, ManageEngine 8020/8383, Struts 8282, Jenkins 8484, WordPress on WAMP 8585, Elasticsearch 9200, SNMP 161/udp |

## Run it

```bash
isoloom run vagrant
isoloom test vagrant
```

VirtualBox or VMware (the providers Rapid7 publishes the box for). About 5 GB of memory (4 GB for
the machine, 1 GB for the controller that runs the checks); the box is a 6 GB download.

Known gap in Rapid7's box: the Rails server (port 3000) never starts. Its scheduled task runs
`rails server`, which exits because the box was built without the app's gems (`bundle check`:
"Bundler can't satisfy your Gemfile's dependencies"), so port 3000 is not part of this lab.

Why not build from source: upstream's Packer build installs Windows Server 2008 R2 from
Microsoft's evaluation ISO, which Microsoft no longer publishes, then installs dozens of
historical packages through Chocolatey on an unsupported OS. Rapid7's box, built from this same
source, is the path upstream's Vagrantfile uses.

Lab guide: the [Metasploitable 3 wiki](https://github.com/rapid7/metasploitable3/wiki).
Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

BSD-3-Clause, as Metasploitable 3 ([LICENSE](LICENSE), [COPYING](COPYING)), copyright Rapid7.

Notice: the box is a Windows Server 2008 R2 evaluation installation under Microsoft's evaluation
terms, and carries third-party software under its own licences (GlassFish, Jenkins, Apache
Struts and Axis2, WordPress, WAMP, ManageEngine Desktop Central, Elasticsearch, Ruby on Rails,
OpenJDK and others; see upstream's [LICENSE](LICENSE) for the ones it bundles). This machine is
deliberately vulnerable: keep it isolated.
