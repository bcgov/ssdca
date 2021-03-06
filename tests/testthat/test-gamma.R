test_that("dgamma extremes", {
  expect_identical(dgamma(numeric(0)), numeric(0))
  expect_identical(dgamma(NA), NA_real_)
  expect_identical(dgamma(NaN), NaN)
  expect_identical(dgamma(0), 1)
  expect_equal(dgamma(1), 0.367879441171442)
  expect_equal(dgamma(1, log = TRUE), log(dgamma(1)))
  expect_equal(dgamma(1, shape = -1), NaN)
  expect_equal(dgamma(1, scale = -1), NaN)
  expect_identical(dgamma(0), 1)
  expect_identical(dgamma(-Inf), 0)
  expect_identical(dgamma(Inf), 0)
  expect_identical(dgamma(c(NA, NaN, 0, Inf, -Inf)), 
                   c(dgamma(NA), dgamma(NaN), dgamma(0), dgamma(Inf), dgamma(-Inf)))
  expect_equal(dgamma(1:2, shape = 1:2, scale = 3:4), 
               c(dgamma(1, 1, 3), dgamma(2, 2, 4)))
  expect_equal(dgamma(1:2, shape = c(1, NA), scale = 3:4), 
               c(dgamma(1, 1, 3), NA))
})

test_that("pgamma extremes", {
  expect_identical(pgamma(numeric(0)), numeric(0))
  expect_identical(pgamma(NA), NA_real_)
  expect_identical(pgamma(NaN), NaN)
  expect_identical(pgamma(0), 0)
  expect_equal(pgamma(1), 0.632120558828558)
  expect_equal(pgamma(1, log.p = TRUE), log(pgamma(1)))
  expect_equal(pgamma(1, lower.tail = FALSE), 1 - pgamma(1))
  expect_equal(pgamma(1, lower.tail = FALSE, log.p = TRUE), log(1 - pgamma(1)))
  expect_equal(pgamma(1, shape = -1), NaN)
  expect_equal(pgamma(1, scale = -1), NaN)
  expect_identical(pgamma(0), 0)
  expect_identical(pgamma(-Inf), 0)
  expect_identical(pgamma(Inf), 1)
  expect_identical(pgamma(c(NA, NaN, 0, Inf, -Inf)), 
                   c(pgamma(NA), pgamma(NaN), pgamma(0), pgamma(Inf), pgamma(-Inf)))
  expect_equal(pgamma(1:2, shape = 1:2, scale = 3:4), 
               c(pgamma(1, 1, 3), pgamma(2, 2, 4)))
  expect_equal(pgamma(1:2, shape = c(1, NA), scale = 3:4), 
               c(pgamma(1, 1, 3), NA))
})

test_that("qgamma extremes", {
  expect_identical(qgamma(numeric(0)), numeric(0))
  expect_identical(qgamma(NA), NA_real_)
  expect_identical(qgamma(NaN), NaN)
  expect_identical(qgamma(0), 0)
  expect_identical(qgamma(1), Inf)
  expect_equal(qgamma(0.75), 1.38629436111989)
  expect_equal(qgamma(0.75, log.p = TRUE), NaN)
  expect_equal(qgamma(log(0.75), log.p = TRUE), qgamma(0.75))
  expect_equal(qgamma(0.75, lower.tail = FALSE), qgamma(0.25))
  expect_equal(qgamma(log(0.75), lower.tail = FALSE, log.p = TRUE), qgamma(0.25))
  expect_equal(qgamma(0.5, shape = -1), NaN)
  expect_equal(qgamma(0.5, scale = -1), NaN)
  expect_identical(qgamma(0), 0)
  expect_identical(qgamma(-Inf), NaN)
  expect_identical(qgamma(Inf), NaN)
  expect_identical(qgamma(c(NA, NaN, 0, Inf, -Inf)), 
                   c(NA, NaN, 0, NaN, NaN))
  expect_equal(qgamma(1:2, shape = 1:2, scale = 3:4), 
               c(qgamma(1, 1, 3), qgamma(2, 2, 4)))
  expect_equal(qgamma(1:2, shape = c(1, NA), scale = 3:4), 
               c(qgamma(1, 1, 3), NA))
  expect_equal(qgamma(pgamma(c(0, 0.1, 0.5, 0.9, 1))), c(0, 0.1, 0.5, 0.9, 1))
})

test_that("rgamma extremes", {
  expect_identical(rgamma(numeric(0)), numeric(0))
  expect_error(rgamma(NA))
  expect_identical(rgamma(0), numeric(0))
  set.seed(42)
  expect_equal(rgamma(1), 1.93929578065309)
  set.seed(42)
  expect_equal(rgamma(1.9), 1.93929578065309)
  set.seed(42)
  expect_equal(rgamma(2), c(1.93929578065309, 0.180419099876704))
  set.seed(42)
  expect_equal(rgamma(3:4), c(1.93929578065309, 0.180419099876704))
  expect_equal(rgamma(0, shape = -1), numeric(0))
  expect_equal(rgamma(1, shape = -1), NaN)
  expect_equal(rgamma(2, shape = -1), c(NaN, NaN))
  expect_equal(rgamma(0, scale = -1), numeric(0))
  expect_equal(rgamma(1, scale = -1), NaN)
  expect_equal(rgamma(2, scale = -1), c(NaN, NaN))
  expect_error(rgamma(1, shape = 1:2))
  expect_error(rgamma(1, scale = 1:2))
  expect_identical(rgamma(1, shape = NA), NA_real_)
})

test_that("fit gamma quinoline", {
  quin <- ssdtools::test_data[ssdtools::test_data$Chemical == "Quinoline", ]

  expect_warning(dist <- ssd_fit_dist(quin, dist = "gamma"))
  expect_true(is.fitdist(dist))
  expect_equal(
    coef(dist),
    c(scale = 41276.5658303504, shape = 0.504923953282222)
  )
})

test_that("fit gamma boron", {
  dist <- ssd_fit_dist(ssdtools::boron_data, dist = "gamma")
  expect_true(is.fitdist(dist))
  expect_equal(
    coef(dist),
    c(scale = 25.1263768579472, shape = 0.950051285831343)
  )
})
