# React Haskell

## Database

Copy the configuration sample:

```
cp snaplets/postgresql-simple/devel.cfg.sample snaplets/postgresql-simple/devel.cfg
```

Then update the file `devel.cfg` with your local DB setup.

## Development

```
sudo apt-get install -y libpcre3-dev
stack build --flag react-haskell:development
```
