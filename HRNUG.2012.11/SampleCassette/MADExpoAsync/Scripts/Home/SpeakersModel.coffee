###
@reference Namespace.coffee
###

class SpeakersModel
   constructor:(@speakers) ->
   sort: (sortBy) =>
      (left, right) ->
         if left[sortBy] < right[sortBy]
            return -1
         return if left[sortBy] > right[sortBy] then 1 else 0

   sortFirstName: () =>
      @speakers.sort(@sort('FirstName'))

   sortLastName: () =>
      @speakers.sort(@sort('LastName'))

namespace "MADExpo", (exports) ->
   exports.SpeakersModel = SpeakersModel