NODE_LTS = "18.16.0"

conf = {
    "cpu": {
        "base_image": "ubuntu:jammy",
        "image_name": "cpu-devbox",
        "extra_post_install_commands": [],
        "node_version": NODE_LTS,
    },

    "gpu": {
        "base_image": "nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04",
        "image_name": "gpu-devbox",
        "extra_post_install_commands": [
            "RUN ln -s /usr/lib/pkgconfig/cuda-12.4.pc /usr/lib/pkgconfig/cuda.pc",
        ],
        "node_version": NODE_LTS,
    }
}


if __name__ == "__main__":

    from jinja2 import Environment, FileSystemLoader

    environment = Environment(loader=FileSystemLoader("templates/"))
    template = environment.get_template("Dockerfile.j2")

    for variant in ("cpu", "gpu"):
        filename = f"generated/Dockerfile.{variant}"
        d = conf[variant]
        content = template.render(**d)
        with open(filename, mode="w", encoding="utf-8") as message:
            message.write(content)
            print(f"... wrote {filename}")

