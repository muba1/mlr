% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/batchmark.R
\name{batchmark}
\alias{batchmark}
\title{Run machine learning benchmarks as distributed experiments.}
\usage{
batchmark(
  learners,
  tasks,
  resamplings,
  measures,
  keep.pred = TRUE,
  keep.extract = FALSE,
  models = FALSE,
  reg = batchtools::getDefaultRegistry()
)
}
\arguments{
\item{learners}{(list of \link{Learner} | \link{character})\cr
Learning algorithms which should be compared, can also be a single learner.
If you pass strings the learners will be created via \link{makeLearner}.}

\item{tasks}{{list of \link{Task}}\cr
Tasks that learners should be run on.}

\item{resamplings}{[(list of) \link{ResampleDesc})\cr
Resampling strategy for each tasks.
If only one is provided, it will be replicated to match the number of tasks.
If missing, a 10-fold cross validation is used.}

\item{measures}{(list of \link{Measure})\cr
Performance measures for all tasks.
If missing, the default measure of the first task is used.}

\item{keep.pred}{(\code{logical(1)})\cr
Keep the prediction data in the \code{pred} slot of the result object.
If you do many experiments (on larger data sets) these objects might unnecessarily increase
object size / mem usage, if you do not really need them.
The default is set to \code{TRUE}.}

\item{keep.extract}{(\code{logical(1)})\cr
Keep the \code{extract} slot of the result object. When creating a lot of
benchmark results with extensive tuning, the resulting R objects can become
very large in size. That is why the tuning results stored in the \code{extract}
slot are removed by default (\code{keep.extract = FALSE}). Note that when
\code{keep.extract = FALSE} you will not be able to conduct analysis in the
tuning results.}

\item{models}{(\code{logical(1)})\cr
Should all fitted models be stored in the \link{ResampleResult}?
Default is \code{FALSE}.}

\item{reg}{(\link[batchtools:makeRegistry]{batchtools::Registry})\cr
Registry, created by \link[batchtools:makeExperimentRegistry]{batchtools::makeExperimentRegistry}. If not
explicitly passed, uses the last created registry.}
}
\value{
(\link{data.table}). Generated job ids are stored in the column
\dQuote{job.id}.
}
\description{
This function is a very parallel version of \link{benchmark} using
\pkg{batchtools}. Experiments are created in the provided registry for each
combination of learners, tasks and resamplings. The experiments are then
stored in a registry and the runs can be started via
\link[batchtools:submitJobs]{batchtools::submitJobs}. A job is one train/test split of the outer
resampling. In case of nested resampling (e.g. with \link{makeTuneWrapper}), each
job is a full run of inner resampling, which can be parallelized in a second
step with \pkg{ParallelMap}.

For details on the usage and support backends have a look at the batchtools
tutorial page: \url{https://github.com/mllg/batchtools}.

The general workflow with \code{batchmark} looks like this:
\enumerate{
\item Create an ExperimentRegistry using \link[batchtools:makeExperimentRegistry]{batchtools::makeExperimentRegistry}.
\item Call \code{batchmark(...)} which defines jobs for all learners and tasks in an \link[base:expand.grid]{base::expand.grid} fashion.
\item Submit jobs using \link[batchtools:submitJobs]{batchtools::submitJobs}.
\item Babysit the computation, wait for all jobs to finish using \link[batchtools:waitForJobs]{batchtools::waitForJobs}.
\item Call \code{reduceBatchmarkResult()} to reduce results into a \link{BenchmarkResult}.
}

If you want to use this with \pkg{OpenML} datasets you can generate tasks
from a vector of dataset IDs easily with \code{tasks = lapply(data.ids, function(x) convertOMLDataSetToMlr(getOMLDataSet(x)))}.
}
\seealso{
Other benchmark: 
\code{\link{BenchmarkResult}},
\code{\link{benchmark}()},
\code{\link{convertBMRToRankMatrix}()},
\code{\link{friedmanPostHocTestBMR}()},
\code{\link{friedmanTestBMR}()},
\code{\link{generateCritDifferencesData}()},
\code{\link{getBMRAggrPerformances}()},
\code{\link{getBMRFeatSelResults}()},
\code{\link{getBMRFilteredFeatures}()},
\code{\link{getBMRLearnerIds}()},
\code{\link{getBMRLearnerShortNames}()},
\code{\link{getBMRLearners}()},
\code{\link{getBMRMeasureIds}()},
\code{\link{getBMRMeasures}()},
\code{\link{getBMRModels}()},
\code{\link{getBMRPerformances}()},
\code{\link{getBMRPredictions}()},
\code{\link{getBMRTaskDescs}()},
\code{\link{getBMRTaskIds}()},
\code{\link{getBMRTuneResults}()},
\code{\link{plotBMRBoxplots}()},
\code{\link{plotBMRRanksAsBarChart}()},
\code{\link{plotBMRSummary}()},
\code{\link{plotCritDifferences}()},
\code{\link{reduceBatchmarkResults}()}
}
\concept{benchmark}
