# namespace.collection

An Ansible collection template.

## Requirements

- Ansible >= 2.9
- Python >= 3.9

## Building the Collection

Build a distributable tarball from the collection source:

```bash
ansible-galaxy collection build
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
