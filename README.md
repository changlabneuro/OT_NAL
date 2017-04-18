# OT_NAL

Analysis and plotting codes used in **Oxytocin under opioid antagonism leads to supralinearenhancement of social attention**

## Organization

- Data are located in the `data` folder. `raw.mat` contains trial-by-trial fixation frequencies as `raw.data`, and labels in `raw.labels` which identify each trial’s parameters (e.g., the category of image). `raw_container.mat` reformats this struct into a `Container`, which is a Matlab object / data structure that makes creating subsets of trials a bit easier. `means.mat` and `standard_errors.mat` contain the means and standard errors as plotted (and per subject / session).

- The object file and associated dependencies of `Container` are stored in `depends`.

- PNAS Pharmacology Data File contains all normalized data used to make supralinear scatter plots in the main text of the paper. Male monkeys are abbreviated M1-6, and female monkeys are abbreviated F1-3. Conditions are abbreviated as follows: saline (SAL), naloxone (NAL), oxytocin (OT), and oxytocin and naloxone combination (OTNAL). For “Overall Face ROI” and “Overall Eye ROI” data are normalized by dividing by SAL. For “Mutual Eye Contact” and “Mutual Reward Receipt” data are normalized by subtracting by SAL. Only the first monkey listed in a given pair of animals was given drug on each day of testing. 

## Non built-ins

All non-builtin files / data structures are included in the repository. These are:

- `ContainerPlotter`: A plotting library.
- `Container`: The aforementioned data / labels object.
- `Assertions`, `SparseLabels`, `Labels`: Additional dependencies of `Container`.

## Analysis + Plotting

- `container_plot_and_save_script`: This script loads in the raw data, performs the saline normalization, recreates **Fig. S2**, and saves basic descriptive statistics as standard Matlab structs in a given directory (currently, the desktop).