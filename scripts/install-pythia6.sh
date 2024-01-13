#!/bin/bash

cd ${ROOT_BUILD_DIR}
wget https://root.cern.ch/download/pythia6.tar.gz
tar zxvf pythia6.tar.gz && rm -rf pythia6.tar.gz
mv pythia6 pythia6416 && cd pythia6416
rm pythia6416.f
wget https://pythia.org/download/pythia6/pythia6428.f
mv pythia6428.f pythia6416.f

cat << EOF > pythia6_common_address.c
#include <string.h>
// declaration of PYTHIA6 common clocks
#ifndef PYTHIA_6_COMMON
#define PYTHIA_6_COMMON
#ifndef WIN32
# define pycomp pycomp_
# define py1ent py1ent_
# define pyjets pyjets_
# define pydat1 pydat1_
# define pydat3 pydat3_
# define type_of_call
#else
# define pycomp PYCOMP
# define py1ent PY1ENT
# define pyjets PYJETS
# define pydat1 PYDAT1
# define pydat3 PYDAT3
# define type_of_call _stdcall
#endif
 
extern int pyjets[2+5*4000+2*2*5*4000];
extern int pydat1[200+2*200+200+2*200];
extern int pydat3[3*500+2*8000+2*8000+5*8000];  /* KNDCAY=8000 */

int* pythia6_common_address(char* name)
{
 if      (!strcmp(name,"PYJETS")) return pyjets;
 else if (!strcmp(name,"PYDAT1")) return pydat1;
 else if (!strcmp(name,"PYDAT3")) return pydat3;
 return 0;
}
#endif
EOF

cat << EOF > makePythia6.linuxx8664
# Compile Fortran source files
gfortran -c -fPIC pythia*.f
gfortran -c -fPIC -fno-second-underscore tpythia6_called_from_cc.F
echo 'void MAIN__() {}' >main.c

# Compile C source files
gcc -c -fPIC main.c
gcc -c -fPIC pythia6_common_address.c

# Create the shared library
gfortran -shared -Wl,-soname,libPythia6.so -o libPythia6.so \
main.o pythia6416.o tpythia6_called_from_cc.o pythia6_common_address.o
EOF

./makePythia6.linuxx8664