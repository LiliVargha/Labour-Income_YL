# Labour income by gender and age

This repository contains the replication files for clustering Labour Income (YL) age profiles for 77 countries and gender specific labour income for 39 countries, as well as visualizing the results using line plots and heatmaps.

## Labour income by age in 77 countries

### FIGURE 1: Labour Income age profile clusters (N=77, 2002-2016)
![Image](https://user-images.githubusercontent.com/68189671/217822610-54cea992-75cc-4aea-8e8b-297c8cf04626.jpg)
### FIGURE 2: Labour Income by age in 77 countries (2002-2016) by 2 clusters and maximum values
![Image](https://user-images.githubusercontent.com/68189671/217785920-4581c8a6-f2b5-4398-b364-67ab416d3598.jpg)

[Download FIGURE 1](https://github.com/LiliVargha/Labour-Income_YL/blob/main/ClusterYL.jpg)
[Download FIGURE 2](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLclusterViz.jpg)

Labour income in National Transfer Accounts includes wages, most of mixed income, as well as all types of labour-related taxes. The values are averages calculated using National Accounts, administrative and survey data in the different countries for ages 0-85+. The values at each age are normalized using the average labour income of age 30-49. Data is from 2002-2016, the most recent country estimations. Clustering is done using a data driven way: using Ward's clustering. Countries in the first cluster are on the bottom of the figure. For more details on the clustering see the presentation and the replication file. For more details on the data see documentation of the data sources.

## Visualizing country differences to the average age specific labour income

### FIGURE 3: Country specific differences to the AVERAGE age specific labour income
![Image](https://user-images.githubusercontent.com/68189671/217836622-d93198e6-a023-49e9-a974-19a054af3033.jpg)

[Download FIGURE 3](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLdiftiles_o.jpg)

## Labour income by gender and age in 39 countries

### FIGURE 4: Gender specific Labour Income age profile clusters (N=39, 2009-2018)
![Image](https://user-images.githubusercontent.com/68189671/218099850-eeecb4f6-35a1-4091-85f5-3b8ff48825fc.jpg)
### FIGURE 5: Labour Income by gender and age in 39 countries (2009-2018) by 3 clusters and maximum values
![Image](https://user-images.githubusercontent.com/68189671/218101159-d2bca60e-1604-45d7-b011-2d4ab81ef889.jpg)

[Download FIGURE 4](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLbygenderCluster.jpg)
[Download FIGURE 5](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLbygenderVizCLUSTER.jpg)

Labour income in National Transfer Accounts includes wages, most of mixed income, as well as all types of labour-related taxes. The values are averages calculated using National Accounts, administrative and survey data in the different countries for ages 0-90+. The values at each age are normalized using the average total labour income of age 30-49. Data is from 2009-2016, the most recent country estimations. Clustering is done using a data driven way: using Ward's clustering.  Countries in the first cluster are on the bottom of the figure. For more details on the clustering see the presentation and the replication file. For more details on the data see documentation of the data sources.


## Other versions of visualizing Labour Income (YL) age profiles

### FIGURE 6: Labour income by age in 77 countries (2002-2016) ordered according to the age of maximum

![Image](https://user-images.githubusercontent.com/68189671/217782623-4506798e-7341-4f95-b84a-edbcf8892971.jpg)

[Download FIGURE 6](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLViz.jpg)

### FIGURE 7: Labour income by gender and age in 39 countries (2009-2018) ordered according to the maximum YL of men

![Image](https://user-images.githubusercontent.com/68189671/218069481-cc0bc883-f16f-400d-bbbb-918957958be1.jpg)

[Download FIGURE 7](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLbygenderViz.jpg)

### FIGURE 8: Difference between age specific YL of women/men & age specific 39 country average YL of women/men

![Image](https://user-images.githubusercontent.com/68189671/218082942-0b07d94b-89f9-4d5c-89c7-c089bfdf1b29.jpg)

[Download FIGURE 8](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YLDIFbygenderViz.jpg)

## Data source
1. [Global NTA results](https://www.ntaccounts.org/web/nta/show/Browse%20database) (Lee and Mason 2011)
2. [European AGENTA Project](http://dataexplorer.wittgensteincentre.org/nta/) (Istenič et al. 2019)
3. [Counting Women's Work](https://www.countingwomenswork.org/data) (Counting Women's Work 2022)
4. [World Population Prospects 2022](https://population.un.org/wpp/) (United Nations, DESA, Population Division: WPP 2022) and [wpp2022 R package](https://github.com/PPgp/wpp2022)

## Replication files
The files for replication is [cluster.R](https://github.com/LiliVargha/Labour-Income_YL/blob/main/cluster.R) for total labour income age profiles and [YL_byGender.R](https://github.com/LiliVargha/Labour-Income_YL/blob/main/YL_byGender.R) for gender specific labour income age profiles. The files contain explanations, different visualizations and types of clustering.

## References
Lili Vargha, Tanja Istenič: Towards a Typology of Economic Lifecycle Patterns. [Presentation at NTA14 Paris](https://ntaccounts.org/web/nta/show/Documents/Meetings/NTA14%20Abstracts), 15 February 2023

Lili Vargha, Bernhard Binder-Hammer, Gretchen Donehower, and Tanja Istenič: [Intergenerational transfers around the world: introducing a new visualization tool](https://www.ntaccounts.org/web/nta/show/Working%20Papers) NTA Working Papers, 2022.  

Lili Vargha, Timothy Miller: Visualizing country differences to the average age specific labour income, Visualization presented at NTA14 Paris.

For the specific R packages see the Replication files.

## Future versions will
- Include newest NTA data.
- Use different ordering (for example by continents).
- Calculate and visualize gender and age specific differences to average labour income and age specific average labour income
