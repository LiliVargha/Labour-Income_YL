# Labour Income Age Profiles (YL) in 77 countries and Labour Income Clusters

This repository contains the replication file for clustering Labour Income (YL) age profiles and visualizing the results using line plots and heatmaps for 77 countries.

Lili Vargha, Tanja Istenič: Towards a Typology of Economic Lifecycle Patterns. [Presentation at NTA14 Paris](https://ntaccounts.org/web/nta/show/Documents/Meetings/NTA14%20Abstracts)

### FIGURE 1: Labour Income age profile clusters (N=77, 2002-2016)
![Image](https://user-images.githubusercontent.com/68189671/217647319-f69bb149-8f31-4e6b-b0da-546720cd6ed4.jpg)
### FIGURE 2: Labour Income by age in 77 countries (2002-2016) by 2 clusters
![Image](https://user-images.githubusercontent.com/68189671/217784213-28a91161-e774-4820-921e-ed6265cf03fa.jpg)

[Download FIGURE 1](https://github.com/LiliVargha/Public-Transfers_TG/blob/main/ClusterTG.jpg)
[Download FIGURE 2](https://github.com/LiliVargha/Public-Transfers_TG/blob/main/ClusterTGtiles.jpg)

Labour income in National Transfer Accounts includes wages, most of mixed income, as well as all types of labour-related taxes. The values are averages calculated using National Accounts, administrative and survey data in the different countries for ages 0-85+. The values at each age are normalized using the average labour income of age 30-49. Data is from 2002-2016, the most recent country estimations. Clustering is done using a data driven way: using Ward's clustering. For more details on this see the presentation and the replication file. For more details on the data see documentation of the data sources.

## Data source
1. [Global NTA results](https://www.ntaccounts.org/web/nta/show/Browse%20database) (Lee and Mason 2011)
2. [European AGENTA Project](http://dataexplorer.wittgensteincentre.org/nta/) (Istenič et al. 2019)

## Replication files
The file for replication is [cluster.R](https://github.com/LiliVargha/Public-Transfers_TG/blob/main/VIZTG.R). The file contains explanation, all the different visualizations and the clustering.

## Other versions of Labour Income age profiles

Lili Vargha, Bernhard Binder-Hammer, Gretchen Donehower, and Tanja Istenič: [Intergenerational transfers around the world: introducing a new visualization tool](https://www.ntaccounts.org/web/nta/show/Working%20Papers) NTA Working Papers, 2022.

### FIGURE 3: Labour Income by age in 77 countries (2002-2016) ordered according to the age of maximum

![Image](https://user-images.githubusercontent.com/68189671/217782623-4506798e-7341-4f95-b84a-edbcf8892971.jpg)

[Download FIGURE 3](https://github.com/LiliVargha/Public-Transfers_TG/blob/main/VizTG.jpg)

### GENDER SPECIFIC LABOUR INCOME clusters and visualizations are found in repository: xxx(link)

## Future versions will
- Include newest NTA data.
- Use different ordering (for example by continents).
