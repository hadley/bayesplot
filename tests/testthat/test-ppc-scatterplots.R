library(bayesplot)
context("PPC: scatterplots")

source(test_path("data-for-ppc-tests.R"))

test_that("ppc_scatter returns ggplot object", {
  expect_gg(ppc_scatter(y, yrep[1,, drop = FALSE]))
  expect_gg(ppc_scatter(y, yrep[1:3, ]))
  expect_gg(ppc_scatter(y2, yrep2))
})

test_that("ppc_scatter_avg returns ggplot object", {
  expect_gg(ppc_scatter_avg(y, yrep))
  expect_gg(ppc_scatter_avg(y2, yrep2))
})

test_that("ppc_scatter_avg same as ppc_scatter if nrow(yrep) = 1", {
  expect_equal(ppc_scatter_avg(y2, yrep2),
               ppc_scatter(y2, yrep2))
  expect_equal(ppc_scatter_avg(y, yrep[1,, drop=FALSE]),
               ppc_scatter(y, yrep[1,, drop = FALSE]))
})

test_that("ppc_scatter_avg_grouped returns a ggplot object", {
  expect_gg(ppc_scatter_avg_grouped(y, yrep, group))
  expect_gg(ppc_scatter_avg_grouped(y, yrep, as.numeric(group)))
  expect_gg(ppc_scatter_avg_grouped(y, yrep, as.integer(group)))

  expect_error(ppc_scatter_avg_grouped(y2, yrep2, group2),
               "'group' must have more than one unique value")
})



# Visual tests ------------------------------------------------------------

test_that("ppc_scatter renders correctly", {
  testthat::skip_on_cran()

  p_base <- ppc_scatter(vdiff_y, vdiff_yrep[1:6, ])
  vdiffr::expect_doppelganger("ppc_scatter (default)", p_base)

  p_custom <- ppc_scatter(
    y = vdiff_y,
    yrep = vdiff_yrep[1:6, ],
    size = 1,
    alpha = 1
  )

  vdiffr::expect_doppelganger(
    title = "ppc_scatter (size, alpha)",
    fig = p_custom)
})

test_that("ppc_scatter_avg renders correctly", {
  testthat::skip_on_cran()

  p_base <- ppc_scatter_avg(vdiff_y, vdiff_yrep)
  vdiffr::expect_doppelganger("ppc_scatter_avg (default)", p_base)

  p_custom <- ppc_scatter_avg(
    y = vdiff_y,
    yrep = vdiff_yrep,
    size = 1.5,
    alpha = .5
  )

  vdiffr::expect_doppelganger(
    title = "ppc_scatter_avg (size, alpha)",
    fig = p_custom)
})

test_that("ppc_scatter_avg_grouped renders correctly", {
  testthat::skip_on_cran()

  p_base <- ppc_scatter_avg_grouped(vdiff_y, vdiff_yrep, vdiff_group)
  vdiffr::expect_doppelganger("ppc_scatter_avg_grouped (default)", p_base)

  p_custom <- ppc_scatter_avg_grouped(
    y = vdiff_y,
    yrep = vdiff_yrep,
    group = vdiff_group,
    size = 3,
    alpha = 0.25
  )

  vdiffr::expect_doppelganger(
    title = "ppc_scatter_avg_grouped (size, alpha)",
    fig = p_custom)
})

