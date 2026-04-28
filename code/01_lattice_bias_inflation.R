# ------------------------------------------------------------------------------
# Script Name: 01_lattice_bias_inflation.R
# Author: Tobias Großbölting
# Date: 2026-04-28


# ------------------------------------------------------------------------------
# Function of this script
# ------------------------------------------------------------------------------
#
# Computes the bias reduction ratio from using the separable class (rectangle)
# instead of the coupled class (disk) for equispaced lattice designs on
# [-1,1]^2 with target at the origin and equal weights.
# Reduction = 1 - 1/rho, where rho = disk_bias / rect_bias >= 1.
# Two settings: symmetric (Mx = Mz = 1) and asymmetric (Mx = 1, Mz = 5).
# Grid sizes: n = 10, 50, 100, 250, 500, 1000.
# Compares finite-n lattice ratios to the continuous limit.
#
#
# ------------------------------------------------------------------------------
# TO-DOs
# ------------------------------------------------------------------------------
#
# 1.
#
# 2.
#
# 3.
#
# ------------------------------------------------------------------------------
# Libraries
# ------------------------------------------------------------------------------




# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

compute_rho <- function(n, Mx, Mz) {
  R <- sqrt(Mx^2 + Mz^2)

  x <- seq(-1, 1, length.out = n + 1)
  z <- seq(-1, 1, length.out = n + 1)
  grid <- expand.grid(x = x, z = z)

  norm_l2 <- sqrt(grid$x^2 + grid$z^2)
  norm_rect <- Mx * abs(grid$x) + Mz * abs(grid$z)

  numerator <- sum(R * norm_l2)
  denominator <- sum(norm_rect)

  numerator / denominator
}

# ------------------------------------------------------------------------------
# Analysis
# ------------------------------------------------------------------------------

grid_sizes <- c(10, 50, 100, 250, 500, 1000, 10000)

# Continuous limit: E[sqrt(x^2 + z^2)] for Uniform([-1,1]^2)
c_limit <- (sqrt(2) + log(1 + sqrt(2))) / 3

# --- Symmetric case: Mx = Mz = 1, R = sqrt(2) ---
Mx_sym <- 1
Mz_sym <- 1
R_sym <- sqrt(Mx_sym^2 + Mz_sym^2)
limit_sym <- R_sym * c_limit / ((Mx_sym + Mz_sym) / 2)
max_sym <- R_sym / Mx_sym

rho_sym <- sapply(grid_sizes, compute_rho, Mx = Mx_sym, Mz = Mz_sym)
reduction_sym <- 1 - 1 / rho_sym
reduction_limit_sym <- 1 - 1 / limit_sym
reduction_max_sym <- 1 - 1 / max_sym

cat("=== Symmetric: Mx = Mz = 1, R = sqrt(2) ===\n")
cat(sprintf("  Maximum reduction: 1 - 1/sqrt(2) = %.1f%%\n", reduction_max_sym * 100))
cat(sprintf("  Continuous limit:  reduction = %.1f%%\n", reduction_limit_sym * 100))
for (i in seq_along(grid_sizes)) {
  cat(sprintf("  n = %4d:          reduction = %.1f%%\n", grid_sizes[i], reduction_sym[i] * 100))
}

# --- Asymmetric case: Mx = 1, Mz = 5, R = sqrt(26) ---
Mx_asym <- 1
Mz_asym <- 5
R_asym <- sqrt(Mx_asym^2 + Mz_asym^2)
limit_asym <- R_asym * c_limit / ((Mx_asym + Mz_asym) / 2)
max_asym <- R_asym / Mx_asym

rho_asym <- sapply(grid_sizes, compute_rho, Mx = Mx_asym, Mz = Mz_asym)
reduction_asym <- 1 - 1 / rho_asym
reduction_limit_asym <- 1 - 1 / limit_asym
reduction_max_asym <- 1 - 1 / max_asym

cat("\n=== Asymmetric: Mx = 1, Mz = 5, R = sqrt(26) ===\n")
cat(sprintf("  Maximum reduction: 1 - 1/sqrt(26) = %.1f%%\n", reduction_max_asym * 100))
cat(sprintf("  Continuous limit:  reduction = %.1f%%\n", reduction_limit_asym * 100))
for (i in seq_along(grid_sizes)) {
  cat(sprintf("  n = %4d:          reduction = %.1f%%\n", grid_sizes[i], reduction_asym[i] * 100))
}

# --- Summary table ---
cat("\n=== Bias Reduction (%) from Separable Class ===\n")
cat(sprintf("%6s  %10s  %10s\n", "n", "Mx=Mz=1", "Mz/Mx=5"))
cat(sprintf("%6s  %10s  %10s\n", "------", "----------", "----------"))
for (i in seq_along(grid_sizes)) {
  cat(sprintf("%6d  %9.1f%%  %9.1f%%\n", grid_sizes[i],
              reduction_sym[i] * 100, reduction_asym[i] * 100))
}
cat(sprintf("%6s  %9.1f%%  %9.1f%%\n", "limit",
            reduction_limit_sym * 100, reduction_limit_asym * 100))
cat(sprintf("%6s  %9.1f%%  %9.1f%%\n", "max",
            reduction_max_sym * 100, reduction_max_asym * 100))


# ------------------------------------------------------------------------------
# Save Outputs
# ------------------------------------------------------------------------------
