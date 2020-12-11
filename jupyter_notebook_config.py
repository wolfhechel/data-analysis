# Traitlet configuration file for jupyter-notebook.
import os

OPENREFINEPATH = os.getenv('OPENREFINEPATH', 'refine')
NOTEBOOKDIR = os.path.join(os.getenv('HOME'), 'work')

c.NotebookApp.notebook_dir = NOTEBOOKDIR

c.ServerProxy.servers = {
    'openrefine': {
        'command': [OPENREFINEPATH, '-p', '{port}','-d', NOTEBOOKDIR ],
        'port': 3333,
        'timeout': 120,
        'launcher_entry': {
            'title': 'OpenRefine Session'
        },
    },
}
