# text-to-bmp
Create background image from text file (Journalctl logs)

Requirements:
- Linux
- Docker or Podman
- Optional: feh (image viewer)
- Optional: picom (compositor for X)

### To build:

```
$ make docker-text-to-bmp
$ make docker-plantuml
```

Use cases:
- Read live updated journalctl logs on your Linux desktop background

![example](./docs/examples/Linux-i3wm-example.png)

- Convert textfile to bmp image format

Provides:
- Docker container "text-to-bmp"
- Docker container "plantuml" for the docs

Docs - Overview

![overview](./docs/diagrams/generated/overview.png)

Docs - update_background script

![overview](./docs/diagrams/generated/update_background.png)
