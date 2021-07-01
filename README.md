There are several ways to "build" this draft, once the repository has
been cloned.

Native Build

To build the draft on the machine where the repository exits, one has to
have all the tools neccesary. These include building other tools (from
source) used by this model, i.e. yanglint and yanger. Details on how
to build them can be found in the link to the tools.

Other than those tools one will need

- python3 and python3-pip
- curl
- rsync
- idnits
- awk (or gawk installed as awk)
- gsed (or sed installed as gsed)

In addition pip should be used to install

- pyang
- xml2rfc
- xym

Once all the tools are installed the following commands will build the draft

% cd draft
% make clean
% make

Build using Docker

In one does not want to be bothered with all the tools necessary to build
the draft, one can use Docker. Make sure it is installed and then in the
root of the repository type

% make container

If the draft is build, it can be copied out of the container into the host
system using the command:

docker cp :/file/path/within/container /host/path/target

