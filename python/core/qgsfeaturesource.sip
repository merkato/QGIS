/************************************************************************
 * This file has been generated automatically from                      *
 *                                                                      *
 * src/core/qgsfeaturesource.h                                          *
 *                                                                      *
 * Do not edit manually ! Edit header and run scripts/sipify.pl again   *
 ************************************************************************/





class QgsFeatureSource
{
%Docstring
 An interface for objects which provide features via a getFeatures method.

.. versionadded:: 3.0
%End

%TypeHeaderCode
#include "qgsfeaturesource.h"
%End
  public:

    virtual ~QgsFeatureSource();

    virtual QgsFeatureIterator getFeatures( const QgsFeatureRequest &request = QgsFeatureRequest() ) const = 0;
%Docstring
 Returns an iterator for the features in the source.
 An optional ``request`` can be used to optimise the returned
 iterator, eg by restricting the returned attributes or geometry.
 :rtype: QgsFeatureIterator
%End

    virtual QgsCoordinateReferenceSystem sourceCrs() const = 0;
%Docstring
 Returns the coordinate reference system for features in the source.
 :rtype: QgsCoordinateReferenceSystem
%End

    virtual QgsFields fields() const = 0;
%Docstring
 Returns the fields associated with features in the source.
 :rtype: QgsFields
%End

    virtual QgsWkbTypes::Type wkbType() const = 0;
%Docstring
 Returns the geometry type for features returned by this source.
 :rtype: QgsWkbTypes.Type
%End


    int __len__() const;
%Docstring
 Returns the number of features contained in the source, or -1
 if the feature count is unknown.
 :rtype: int
%End
%MethodCode
    sipRes = sipCpp->featureCount();
%End

    virtual long featureCount() const = 0;
%Docstring
 Returns the number of features contained in the source, or -1
 if the feature count is unknown.
 :rtype: long
%End

};


/************************************************************************
 * This file has been generated automatically from                      *
 *                                                                      *
 * src/core/qgsfeaturesource.h                                          *
 *                                                                      *
 * Do not edit manually ! Edit header and run scripts/sipify.pl again   *
 ************************************************************************/
