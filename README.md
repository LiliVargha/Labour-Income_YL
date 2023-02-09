# Labour income age profile clusters and visualization, total (77 countries) and gender specific (39 countries)

This repository contains the replication file for clustering Labour Income (YL) age profiles for 77 countries and gender specific labour income for 39 countries, as well as visualizing the results using line plots and heatmaps.

Lili Vargha, Tanja Istenič: Towards a Typology of Economic Lifecycle Patterns. [Presentation at NTA14 Paris](https://ntaccounts.org/web/nta/show/Documents/Meetings/NTA14%20Abstracts)

### FIGURE 1: Labour Income age profile clusters (N=77, 2002-2016)
![Image](https://user-images.githubusercontent.com/68189671/217822610-54cea992-75cc-4aea-8e8b-297c8cf04626.jpg)
### FIGURE 2: Labour Income by age in 77 countries (2002-2016) by 2 clusters and maximum values
![Image](https://user-images.githubusercontent.com/68189671/217785920-4581c8a6-f2b5-4398-b364-67ab416d3598.jpg)

[Download FIGURE 1](https://github.com/LiliVargha/Labour-Income_YL/blob/main/ClusterYL.jpg)
[Download FIGURE 2](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLclusterViz.jpg)

Labour income in National Transfer Accounts includes wages, most of mixed income, as well as all types of labour-related taxes. The values are averages calculated using National Accounts, administrative and survey data in the different countries for ages 0-85+. The values at each age are normalized using the average labour income of age 30-49. Data is from 2002-2016, the most recent country estimations. Clustering is done using a data driven way: using Ward's clustering. For more details on this see the presentation and the replication file. For more details on the data see documentation of the data sources.

### FIGURE 3: Gender specific Labour Income age profile clusters (N=39, 2009-2018)
![Image](https://user-images.githubusercontent.com/68189671/217822610-54cea992-75cc-4aea-8e8b-297c8cf04626.jpg)
### FIGURE 4: Labour Income by gender and age in 39 countries (2009-2018) by 3 clusters and maximum values
![Image](https://user-images.githubusercontent.com/68189671/217785920-4581c8a6-f2b5-4398-b364-67ab416d3598.jpg)

[Download FIGURE 3](https://github.com/LiliVargha/Labour-Income_YL/blob/main/ClusterYL.jpg)
[Download FIGURE 4](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLclusterViz.jpg)

Labour income in National Transfer Accounts includes wages, most of mixed income, as well as all types of labour-related taxes. The values are averages calculated using National Accounts, administrative and survey data in the different countries for ages 0-90+. The values at each age are normalized using the average total labour income of age 30-49. Data is from 2009-2016, the most recent country estimations. Clustering is done using a data driven way: using Ward's clustering. For more details on this see the presentation and the replication file. For more details on the data see documentation of the data sources.

## Data source
1. [Global NTA results](https://www.ntaccounts.org/web/nta/show/Browse%20database) (Lee and Mason 2011)
2. [European AGENTA Project](http://dataexplorer.wittgensteincentre.org/nta/) (Istenič et al. 2019)
3. [Counting Women's Work](https://www.countingwomenswork.org/data)(Counting Women's Work 2022)

## Visualizing country differences to the average labour income
Lili Vargha, Timothy Miller

### FIGURE 5: Country specific differences to the AVERAGE age specific labour income
![Image](https://user-images.githubusercontent.com/68189671/217836622-d93198e6-a023-49e9-a974-19a054af3033.jpg)

[Download FIGURE 5](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLdiftiles_o.jpg)

## Replication files
The files for replication is [cluster.R](https://github.com/LiliVargha/Labour-Income_YL/blob/main/cluster.R) for total labour income age profiles and [YL_byGender.R](link) for gender specific labour income age profiles. The files contain explanation, all the different visualizations and the clustering.

## Other versions of visualizing Labour Income (YL) age profiles

Lili Vargha, Bernhard Binder-Hammer, Gretchen Donehower, and Tanja Istenič: [Intergenerational transfers around the world: introducing a new visualization tool](https://www.ntaccounts.org/web/nta/show/Working%20Papers) NTA Working Papers, 2022.

### FIGURE 6: Labour income by age in 77 countries (2002-2016) ordered according to the age of maximum

![Image](https://user-images.githubusercontent.com/68189671/217782623-4506798e-7341-4f95-b84a-edbcf8892971.jpg)

[Download FIGURE 6](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLViz.jpg)


## Future versions will
- Include newest NTA data.
- Use different ordering (for example by continents).
- Calculate and visualize gender and age specific differences to average labour income and average age specific labour income
