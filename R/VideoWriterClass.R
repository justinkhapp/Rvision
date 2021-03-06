#' @title An S4 Class Containing an OpenCV Video Writer
#'
#' @name VideoWriter-class
#'
#' @aliases Rcpp_VideoWriter
#'
#' @docType class
#'
#' @description \code{VideoWriter} objects contains an \href{http://opencv.org/}{OpenCV}
#'  video writer to an output file.
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#' @export
"VideoWriter"


#' @title Create an object of class \code{VideoWriter}
#'
#' @description Function for creating \code{\link{VideoWriter}} objects.
#'
#' @param outputFile An character string corresponding to the path to an output
#'  file.
#'
#' @param fourcc A 4-character string corresponding to the fourcc code of the
#'  codec to be used. A list of fourcc codes can be obtained at
#'  \href{http://www.fourcc.org/codecs.php}{http://www.fourcc.org/codecs.php}.
#'
#' @param fps A numeric value corresponding to the framerate of the output video.
#'
#' @param height An integer value corresponding to the height of the video in
#'  pixels.
#'
#' @param width An integer value corresponding to the width of the video in
#'  pixels.
#'
#' @param isColor A logical indicating whether the output video is a color
#'  (default: TRUE) or grayscale (FALSE) video.
#'
#' @param api A character string corresponding to the API to use for reading the
#'  video from the file (see Note; default: "ANY").
#'
#' @return A \code{\link{VideoWriter}} object.
#'
#' @note Hereafter is a list of all supported APIs. Note that not all APIs will
#'  be available on your computer (actually most of them will not be).
#'  \itemize{
#'   \item{"ANY": }{automatically select an API.}
#'   \item{"VFW": }{Video For Windows.}
#'   \item{"V4L", "V4L2": }{Video For Linux.}
#'   \item{"FIREWIRE", "FIREWARE", "IEEE1394", "DC1394", "CMU1394": }{IEEE 1394 drivers.}
#'   \item{"QT": }{Quicktime.}
#'   \item{"UNICAP": }{Unicap drivers.}
#'   \item{"DSHOW": }{DirectShow.}
#'   \item{"PVAPI": }{PvAPI, Prosilica GigE SDK.}
#'   \item{"OPENNI": }{OpenNI (for Kinect).}
#'   \item{"OPENNI_ASUS": }{OpenNI (for Asus Xtion).}
#'   \item{"XIAPI": }{XIMEA Camera API.}
#'   \item{"AVFOUNDATION": }{AVFoundation framework for iOS and OSX > Lion.}
#'   \item{"GIGANETIX": }{Smartek Giganetix GigEVisionSDK.}
#'   \item{"MSMF": }{Microsoft Media Foundation.}
#'   \item{"WINRT": }{Microsoft Windows Runtime using Media Foundation.}
#'   \item{"INTELPERC": }{Intel Perceptual Computing SDK.}
#'   \item{"OPENNI2": }{OpenNI2 (for Kinect).}
#'   \item{"OPENNI2_ASUS": }{OpenNI2 (for Asus Xtion and Occipital Structure sensors).}
#'   \item{"GPHOTO2": }{gPhoto2 connection.}
#'   \item{"GSTREAMER": }{GStreamer.}
#'   \item{"FFMPEG": }{FFMPEG library.}
#'   \item{"IMAGES": }{OpenCV Image Sequence.}
#'   \item{"ARAVIS": }{Aravis SDK.}
#'   \item{"OPENCV_MJPEG": }{Built-in OpenCV MotionJPEG codec.}
#'   \item{"INTEL_MFX": }{Intel MediaSDK.}
#'  }
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @examples
#' # TODO
#'
#' @export
videoWriter <- function(outputFile, fourcc, fps, height, width, isColor = TRUE,
                        api = "ANY") {
  new(VideoWriter, outputFile = outputFile, fourcc = fourcc, fps = fps,
      height = height, width = width, isColor = isColor, api = api)
}


#' @title Test for a VideoWriter object
#'
#' @description Tests whether the object is of class \code{\link{VideoWriter}}
#'
#' @param object Any R object.
#'
#' @return A logical indicating whether the object is of class
#'  \code{\link{VideoWriter}} (TRUE) or not (FALSE).
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @seealso \code{\link{VideoWriter}}, \code{\link{videoWriter}}
#'
#' @examples
#' # TODO
#' @export
#'
isVideoWriter <- function(object) {
  inherits(object, "Rcpp_VideoWriter") & tryCatch(object$isOpened(), error = function(e) FALSE)
}


#' @export
#' @rdname release
release.Rcpp_VideoWriter <- function(obj) {
  if (!isVideoWriter(obj))
    stop("This is not a VideoWriter object.")

  obj$release()

  if (!obj$isOpened()) {
    tmp <- deparse(substitute(obj))
    rm(list = tmp, envir = parent.frame(1))
    message("VideoWriter released successfully. \n")
  } else {
    message("An error occured while trying to release the video writer \n")
  }
}


#' @title Write Frame to Output Video
#'
#' @description Write an \code{\link{Image}} object to an output video using a
#'  \code{\link{VideoWriter}} object.
#'
#' @param x A \code{\link{VideoWriter}} object.
#'
#' @param frame An \code{\link{Image}} object.
#'
#' @return This function does not return anything.
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @seealso \code{\link{VideoWriter}}, \code{\link{Image}}
#'
#' @examples
#' # TODO
#' @export
writeFrame <- function(x, frame) {
  if (!isVideoWriter(x))
    stop("This is not a VideoWriter object.")

  if (!isImage(frame))
    stop("This is not an Image object.")

  x$write(frame)
}


#' @rdname setProp
#' @export
setProp.Rcpp_VideoWriter <- function(obj, property, value) {
  if (!isVideoWriter(obj))
    stop("This is not a VideoWriter object.")

  obj$set(property, value)
}


#' @export
#' @rdname setProp
getProp.Rcpp_VideoWriter <- function(obj, property) {
  if (!isVideoWriter(obj))
    stop("This is not a VideoWriter object.")

  obj$get(property)
}


#' @title Dimensions of a Video Writer
#'
#' @description Retrieve the dimensions a \code{\link{VideoWriter}} object.
#'
#' @param x A \code{\link{VideoWriter}} object.
#'
#' @return A vector with 2 values corresponding to the number of rows and columns
#'  of the video writer (in this order).
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @seealso \code{\link{VideoWriter}}, \code{\link{videoWriter}}
#'
#' @examples
#' # TODO
#'
#' @export
dim.Rcpp_VideoWriter <- function(x) {
  x$dim()
}


#' @title The Number of Rows/Columns of a Video Writer
#'
#' @aliases ncol.Rcpp_VideoWriter
#'
#' @description nrow, ncol return the number of rows or columns present in a
#'  \code{\link{VideoWriter}} object.
#'
#' @param x A \code{\link{VideoWriter}} object.
#'
#' @return A numeric value.
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @seealso \code{\link[=dim.Rcpp_VideoWriter]{dim}} which returns \emph{all}
#'  dimensions.
#'
#' @examples
#' # TODO
#'
#' @export
#' @rdname videowriter_dimensions
nrow.Rcpp_VideoWriter <- function(x) {
  x$nrow()
}

#' @rdname videowriter_dimensions
#' @export
ncol.Rcpp_VideoWriter <- function(x) {
  x$ncol()
}


#' @export
#' @rdname fps
fps.Rcpp_VideoWriter <- function(obj) {
  if (!isVideoWriter(obj))
    stop("This is not a VideoWriter object.")

  obj$fps()
}


#' @export
#' @rdname codec
codec.Rcpp_VideoWriter <- function(obj) {
  if (!isVideoWriter(obj))
    stop("This is not a VideoWriter object.")

  obj$codec()
}


#' @title API of a Video Writer
#'
#' @description Retrieve the API of a \code{\link{VideoWriter}} object.
#'
#' @param x A \code{\link{VideoWriter}} object.
#'
#' @return A character string corresponding to the API used by the
#'  \code{\link{VideoWriter}} object to write the video.
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @seealso \code{\link{VideoWriter}}, \code{\link{videoWriter}}
#'
#' @examples
#' # TODO
#' @export
api <- function(x) {
  if (!isVideoWriter(x))
    stop("This is not a VideoWriter object.")

  x$api()
}


#' @title Output File of a Video Writer
#'
#' @description Retrieve the output file of a \code{\link{VideoWriter}} object.
#'
#' @param x A \code{\link{VideoWriter}} object.
#'
#' @return A character string corresponding to the address of the output file on
#'  the hard drive.
#'
#' @author Simon Garnier, \email{garnier@@njit.edu}
#'
#' @seealso \code{\link{VideoWriter}}, \code{\link{videoWriter}}
#'
#' @examples
#' # TODO
#' @export
writerOuput <- function(x) {
  if (!isVideoWriter(x))
    stop("This is not a VideoWriter object.")

  x$output()
}