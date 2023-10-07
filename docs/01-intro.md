# Introduction

> I have adapted this from the intro to data viz

Use of the programming language R (R Core Team, 2022) for data processing and statistical analysis by researchers continues to grow, in part fueled by increasing recognition for the needed for research in all fields to be transparent and reproducible (CITATIONS). In Nordmann et al., (2022) we provided an introductory tutorial to data visualization in R to help support researchers to produce reproducible visualisations that increase transparency regarding the true nature of the raw data, rather than relying on aggregated plots such as bar charts. 

Data wrangling is the art of cleaning, structuring, and transforming raw data into a desired format so that further analysis or visualization can be performed (GET DEFINTION CITATION). Although data wrangling is the first and most essential step in any analysis pipeline, it can often prove the most difficult in part due to the maxim that "all tidy datasets are tidy in the same way, all messy datasets are messy in their own way" (Whickam, tidy data paper CHECK QUOTE IS ACTUALLY THOSE WORDS). Indeed, the rationale for Nordmann et al., (2022) was that although data visualisation is not the first step of the analysis pipeline, it is perhaps the most accessible for encouraging researchers to learn to in code. In recognition of this difficulty, we went as far as to encourage performing pre-processing steps in point-and-click software if it allowed researchers to move to visualizing their data using R. In this follow-up tutorial, we build on the experience (and hopefully confidence) established through our first tutorial to help support the development of skills related to this more difficult, yet arguably more crucial process. The current tutorial is stand-alone and can be completed without working through Nordmann et al., (2022), although as a set they may prove particularly useful.

## Why R for data wrangling?

- Reproducibiity
- Ability to share code
- Can save time when you have to re-run analysis steps, can write code based on pilot or simulated data whilst waiting for ethics or data collection etc.
- Advanced data wrangling options, pivots, joins etc., allows researchers to use tools of data science
- Gives better understanding of data structures, more difficult initially, but in long-run, gives more control and knowledge.

## Tutorial components

This tutorial contains three components.

* A traditional PDF manuscript that can easily be saved, printed, and cited.
* An online version of the tutorial published at https://psyteachr.github.io/introdatawrangling/ that may be easier to copy and paste code from and that also provides the optional activity solutions as well as additional appendices, including code tutorials for advanced plots beyond the scope of this paper and links to additional resources.
* An Open Science Framework repository published at INSERT OSF LINK that contains the simulated dataset (see below), preprint, and R Markdown workbook.

## Simluated dataset

In Nordmann et al. (2022), we used a simulated dataset for a lexical decision task in which 100 participants had to decide whether a presented word was a real word or a non-word. This dataset was cleaned and aggregated, that is, for each participant there was a single aggregated reaction time and a single aggregated accuracy score for each condition that averaged over a number of trials.

In the current tutorial, our simulated data represents the raw data that would have been used to create the aggregated data from Nordmann et al. (2022) (although please note that it is a simulation of a simulation, i.e., the raw data provided in this tutorial will not reproduce the same means as in the previous tutorial UNLESS LISA CAN DO SOMETHING WITH MY CODE TO MAKE THIS HAPPEN).

There are 102 files in total.

* `all_words.csv` has three variables: `word` (the word that is presented in each trial), `type` (whether the word was a real word or non-word), and `trial_type` (practice trial or experimental trial). There are 111 rows of data, a header row with the variable names, 100 experimental trials (50 real words and 50 non-words), and 10 practice trials (5 real words and 5 non-words).

* `participant_demographics` has three variables: `id` an anonymous ID number from 1 to 100, `age` in whole years, and `language` (1 = monolingual, 2 = bilingual).

* The folder `ppt_data` then contains 100 separate .csv files, one for each participant, named in the format `participant_1_trials.csv`. Each file contains six variables; `id` (the participant's anonymous ID number), `word` (the word that is presented in each trial), `accuracy` (whether the participant correctly identified if the word was real or not with two values `correct` or `incorrect`), `rt` (the participant's reaction time to respond to each trial in milliseconds), `trial_type` (practice trial or experimental trial), and `trial_number` (the order each trial was presented in, from 1 to 110).




















