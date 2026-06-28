# namespace.collection

An Ansible collection template.

## Collection Structure

```
namespace/
    collection/
    ├── galaxy.yml              # Collection metadata (name, version, dependencies)
    ├── README.md
    ├── LICENSE
    ├── meta/
    │   └── runtime.yml         # Ansible version requirements, plugin routing
    ├── docs/                   # Extra documentation
    ├── plugins/
    │   ├── modules/            # Custom modules (.py)
    │   ├── module_utils/       # Shared module helpers
    │   ├── lookup/             # Lookup plugins
    │   ├── filter/             # Filter plugins (Jinja2)
    │   ├── test/               # Test plugins (Jinja2)
    │   ├── inventory/          # Dynamic inventory plugins
    │   ├── callback/           # Callback plugins (output/logging)
    │   ├── connection/         # Connection plugins
    │   └── vars/               # Vars plugins
    ├── roles/
    │   └── my_role/
    │       ├── tasks/
    │       │   └── main.yml
    │       ├── handlers/
    │       │   └── main.yml
    │       ├── defaults/
    │       │   └── main.yml    # Low-priority default variables
    │       ├── vars/
    │       │   └── main.yml    # High-priority role variables
    │       ├── files/          # Static files for copy/script tasks
    │       ├── templates/      # Jinja2 templates
    │       └── meta/
    │           └── main.yml    # Role dependencies
    ├── playbooks/              # Standalone playbooks
    └── tests/
        ├── integration/        # Integration tests (ansible-test)
        └── unit/               # Unit tests (ansible-test)
```

## Building the Collection

Build a distributable tarball from the collection source:

```bash
./scripts/ansible/build.sh
```

## Installing the Collection

Install from the local tarball:

```bash
ansible-galaxy collection install namespace-collection-1.0.0.tar.gz
```

## Usage
```yaml
- hosts: all
  collections:
    - namespace.collection
  tasks:
    - name: Use a module from this collection
      namespace.collection.module1:
```

## License

See [LICENSE](LICENSE).
