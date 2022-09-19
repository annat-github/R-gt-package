
# load libraries ----------------------------------------------------------

library(tidyverse)
library(gt)

# set working directory ---------------------------------------------------

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load dataframe available in gt ------------------------------------------
exibble

# useful functions for tables available in gt -----------------------------

# create/modify parts
# tab_header() # add a table header
# tab_spanner() # add a spanner column label
# tab_row_group() # add a row_group
# tab_stubhead_label() #add label text to the stubhead
# tab_footnote() # add a footnote
# tab_source_note() #add a source note citation
# 
# # format data
# fmt_number() #format numeric values
# fmt_scientific() # format values to scientific notation
# fmt_percent() #format values ad a percentage
# fmt_currency() #format values as currencies
# fmt_date()
# fmt_datetime()
# fmt_time()
# fmt_missing() #format missing values

# create a table with gt --------------------------------------------------

exibble %>% gt()
 
#create a stub and include row groups
tab <- exibble %>% gt(
                      rowname_col = "row",
                      groupname_col = "group"
                      )
tab

#Format the 'number' column 
tab_2 <- tab %>% fmt_scientific(
  columns = vars(num), #supply column name wrapped in vars()
  decimals = 3 #supply number of decimals you want to keep
)

tab_2

#Format the dates in 'date' (but only those rows that satisfy a condition) with 'date_style' 6

tab_3 <- 
  tab_2 %>% 
  fmt_date(
    columns = vars(date),
    rows = grepl("^[a-d]", char),# for the rows in char that begin with a-d
    date_style = 6
  )
tab_3

# info on 'date styles'

info_date_style()

#other info tables
info_currencies() # to format currencies
info_time_style() # to format time
info_paletteer() # to colour cells

#if you want to hide some columns because you don't need them
tab_4 <- tab_3 %>%
   cols_hide(
     columns = vars(char,fctr,time,datetime)
   )

tab_4

#format the currency column to have values in pounds
tab_5 <- tab_4 %>%
  fmt_currency(
    columns = vars(currency),
    currency = "GBP"
  )

tab_5

# adding footnotes to some of the 'currency' values with tab_footnote()
tab_6 <- tab_5 %>%
  tab_footnote(
    footnote = "These are lower prices",
    locations = cells_body(
      columns = vars(currency),
      rows = currency < 20
    )
  )

tab_6
# add a footnote to the 'currency' column label 
tab_7 <-
  tab_6 %>%
  tab_footnote(
    footnote = "All values are in GBP",
    locations = cells_column_labels(
      columns = vars(currency)
    )
  )
tab_7

#add a header to the table (with title and subtitle)
tab_8 <- tab_7 %>%
  tab_header(
    title = " An example",
    subtitle = md("Uses the *exibble* dataset from **gt**") # uses 'md' Markdown to render to HTML 
  )                                                         # * * for Italic and ** ** for bold
tab_8

#have the footnote glyphs be a sequence of lowercase letter (tab_options( has options galore))
tab_9 <- tab_8 %>%
  tab_options(footnotes.marks = "letters") #for uppercase use "LETTERS"

tab_9

#color the stub cells in blue
tab_10 <- tab_9 %>%
  tab_options(column_labels.background.color = "blue")
tab_10


