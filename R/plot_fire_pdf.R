#' @title plot_fire_pdf
#'
#' @description Plot PDF of fire index
#'
#' @param fire_index RasterBrick containing the fire index
#' @param thresholds thresholds calculated using the function
#' \code{danger_levels()}
#' @param upper_limit FWI upper limit to visualise
#' (the default is the maximum FWI)
#' @param v_lines named vector of values to plot as vertical lines
#' (this can be quantiles for comparison)
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   plot_fire_pdf(fire_index, thresholds, upper_limit = 100)
#' }
#'

plot_fire_pdf <- function(fire_index,
                          thresholds,
                          upper_limit = NULL,
                          v_lines = NULL){

  fire_palette <- c("#4DAF4A", "#FFFF33", "#FF7F00",
                    "#E41A1C", "#6b3535", "#403131")

  idx <- na.omit(as.vector(fire_index))
  idxno0 <- idx[idx > 0]

  # percentiles corresponding to the danger thresholds:
  cols <- c("VeryLow" = fire_palette[1],
            "Low" = fire_palette[2],
            "Moderate" = fire_palette[3],
            "High" = fire_palette[4],
            "Very high" = fire_palette[5],
            "Extreme" = fire_palette[6])

  if (is.null(upper_limit)) {

    upper_limit <- ceiling(max(idxno0))

  }

  danger_classes <- c(0, thresholds, upper_limit)

  vdistance <- max(density(idxno0)$y) / 15
  hdistance <- max(danger_classes) / 100

  x1 <- x2 <- y1 <- y2 <- NULL # to avoid warning in check!

  df <- data.frame(x1 = danger_classes[1:6],
                   x2 = danger_classes[2:7],
                   y1 = min(density(idxno0)$y) - vdistance,
                   y2 = min(density(idxno0)$y) - vdistance,
                   danger_levels = factor(x = fire_palette,
                                         levels = c(fire_palette)))

  p <- ggplot(as.data.frame(idxno0), aes(idxno0)) +
    geom_density(colour = "#6d6b6b", fill = "grey") +
    geom_segment(aes(x = x1, y = y1,
                     xend = x2, yend = y2, colour = df$danger_levels),
                 data = df, size = 14) +
    scale_colour_manual(name = "Danger classes",
                        values = fire_palette,
                        labels = c("Very Low", "Low", "Moderate",
                                   "High", "Very high", "Extreme")) +
    geom_text(aes(x = x1 + hdistance, y = y1,
                         label = round(x1, 0)),
              data = df[2:6, ], size = 5, colour = "#e1dbdb") +
    theme_bw() + xlab("FWI") + ylab("Density") +
    theme(legend.title = element_text(size = 10, face = "bold"),
          text = element_text(size = 10, lineheight = .8),
          legend.position = c(0.98, 0.98), legend.justification = c(1, 1)) +
    scale_x_continuous(limits = c(0, upper_limit))

  label <- value <- NULL # to avoid NOTE during check
  if (!is.null(v_lines)) {

    dfv <- data.frame(label = names(v_lines), value = as.numeric(v_lines))
    p <- p + geom_vline(data = dfv, mapping = aes(xintercept = value),
                        color = "darkgray", linetype = 2) +
      geom_text(data = dfv, mapping = aes(x = value, y = max(density(idxno0)$y),
                                          label = label),
                angle = 90, vjust = -0.4, colour = "#585858")

  }

  return(p)

}
