# OT_NAL

Analysis and plotting codes used in **Oxytocin under opioid antagonism leads to supralinearenhancement of social attention**

## Organization

- Data are located in the `data` folder. `raw.mat` contains trial-by-trial fixation frequencies as `raw.data`, and labels in `data.labels` which identify each trial’s parameters (e.g., the category of image). `raw_container.mat` reformats this struct into a `Container`, which is a Matlab object / data structure that makes creating subsets of trials a bit easier.

- The object file and associated dependencies of `Container` are stored in `depends`.

## Non built-ins

All non-builtin files / data structures are included in the repository. These are:

- `ContainerPlotter`: A plotting library.
- `Container`: The aforementioned data / labels object.
- `Assertions`, `SparseLabels`, `Labels`: Additional dependencies of `Container`.

## Analysis + Plotting

- `container_plot_and_save_script`: This script loads in the raw data, performs the saline normalization, recreates **Fig. S2**, and saves basic descriptive statistics as standard Matlab structs in a given directory (currently, the desktop).