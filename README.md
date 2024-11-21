## Grocery Price Analysis in Canada using SQL Observational Data Analysis

## Overview

Project Hammer is aimed at fostering competition and reducing collusion within 
the Canadian grocery sector by compiling and analyzing historical grocery prices 
from major Canadian retailers. The primary goals include creating a comprehensive 
price database, making it accessible for academic and legal analysis, and 
informing stakeholders and changemakers in the field.

This project includes eight vendors: Voila, T&T, Loblaws, No Frills, Metro, 
Galleria, Walmart, and Save-On-Foods. The database captures grocery prices from 
February 28, 2024, to the most recent load, with prices updated for in-store 
pickup in a Toronto neighborhood.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from https://jacobfilipp.com/hammer/.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains details about LLM chat interactions.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of part of the code and paper were written with the help of the ChatGPT. 
The entire chat history is available in inputs/llms/usage.txt.
