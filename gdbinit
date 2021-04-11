set disassembly-flavor intel


# Load peda-gdb if its there
python

import os.path

peda = "/home/daniel/code/peda/peda.py"

if os.path.isfile(peda):
    gdb.execute("source %s" % peda)

end
