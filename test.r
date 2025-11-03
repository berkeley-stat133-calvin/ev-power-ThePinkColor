# cleaning total energy use 2023
total_energy23 <- read.csv('data/total-use-2023.csv', skip = 2)
total_energy23

clean_headers <- function(headers) {
    headers |>
    str_trim() |> # remove leading/trailing whitespace
    str_to_lower() |> # standardize to lowercase
    str_replace_all("[^a-z0-9_\\s]", "") |> # remove special characters
    str_replace_all("[-_]", " ") |> # normalize separators
    str_replace_all("\\s+", "_") # convert to snake_case
}

# example:
names(total_energy23) <- clean_headers(names(total_energy23))
total_energy23

# state names are not lowercase and spelled out, so must first change state names so they can# adding DC to list of state names
state_fulls <- c(datasets::state.name, "District of Columbia")
state_fulls
state_abbs <- c(datasets::state.abb, "DC")
state_abbs

# changing state abbreviations to full names
state_lookup <- tibble(state_fulls, state_abbs)
state_lookup

total_energy23 |>
    left_join(state_lookup, by = join_by('State' == 'state_abbs'))
total_energy23

head(total_energy23)