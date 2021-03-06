# -*- coding: utf-8 -*-

"""
***************************************************************************
    RasterLayerStatistics.py
    ---------------------
    Date                 : January 2013
    Copyright            : (C) 2013 by Victor Olaya
    Email                : volayaf at gmail dot com
***************************************************************************
*                                                                         *
*   This program is free software; you can redistribute it and/or modify  *
*   it under the terms of the GNU General Public License as published by  *
*   the Free Software Foundation; either version 2 of the License, or     *
*   (at your option) any later version.                                   *
*                                                                         *
***************************************************************************
"""
from builtins import str

__author__ = 'Victor Olaya'
__date__ = 'January 2013'
__copyright__ = '(C) 2013, Victor Olaya'

# This will get replaced with a git SHA1 when you do a git archive

__revision__ = '$Format:%H$'

import math
import codecs

from qgis.core import (QgsApplication,
                       QgsProcessingUtils)
from processing.core.GeoAlgorithm import GeoAlgorithm
from processing.core.parameters import ParameterRaster
from processing.core.outputs import OutputNumber
from processing.core.outputs import OutputHTML
from processing.tools import raster


class RasterLayerStatistics(GeoAlgorithm):

    INPUT = 'INPUT'

    MIN = 'MIN'
    MAX = 'MAX'
    SUM = 'SUM'
    MEAN = 'MEAN'
    COUNT = 'COUNT'
    NO_DATA_COUNT = 'NO_DATA_COUNT'
    STD_DEV = 'STD_DEV'
    OUTPUT_HTML_FILE = 'OUTPUT_HTML_FILE'

    def icon(self):
        return QgsApplication.getThemeIcon("/providerQgis.svg")

    def svgIconPath(self):
        return QgsApplication.iconPath("providerQgis.svg")

    def group(self):
        return self.tr('Raster tools')

    def name(self):
        return 'rasterlayerstatistics'

    def displayName(self):
        return self.tr('Raster layer statistics')

    def defineCharacteristics(self):
        self.addParameter(ParameterRaster(self.INPUT, self.tr('Input layer')))

        self.addOutput(OutputHTML(self.OUTPUT_HTML_FILE, self.tr('Statistics')))
        self.addOutput(OutputNumber(self.MIN, self.tr('Minimum value')))
        self.addOutput(OutputNumber(self.MAX, self.tr('Maximum value')))
        self.addOutput(OutputNumber(self.SUM, self.tr('Sum')))
        self.addOutput(OutputNumber(self.MEAN, self.tr('Mean value')))
        self.addOutput(OutputNumber(self.COUNT, self.tr('valid cells count')))
        self.addOutput(OutputNumber(self.COUNT, self.tr('No-data cells count')))
        self.addOutput(OutputNumber(self.STD_DEV, self.tr('Standard deviation')))

    def processAlgorithm(self, context, feedback):
        outputFile = self.getOutputValue(self.OUTPUT_HTML_FILE)
        uri = self.getParameterValue(self.INPUT)
        layer = QgsProcessingUtils.mapLayerFromString(uri, context)
        values = raster.scanraster(layer, feedback)

        n = 0
        nodata = 0
        mean = 0
        M2 = 0
        sum = 0
        minvalue = None
        maxvalue = None

        for v in values:
            if v is not None:
                sum += v
                n = n + 1
                delta = v - mean
                mean = mean + delta / n
                M2 = M2 + delta * (v - mean)
                if minvalue is None:
                    minvalue = v
                    maxvalue = v
                else:
                    minvalue = min(v, minvalue)
                    maxvalue = max(v, maxvalue)
            else:
                nodata += 1

        variance = M2 / (n - 1)
        stddev = math.sqrt(variance)

        data = []
        data.append('Valid cells: ' + str(n))
        data.append('No-data cells: ' + str(nodata))
        data.append('Minimum value: ' + str(minvalue))
        data.append('Maximum value: ' + str(maxvalue))
        data.append('Sum: ' + str(sum))
        data.append('Mean value: ' + str(mean))
        data.append('Standard deviation: ' + str(stddev))

        self.createHTML(outputFile, data)

        self.setOutputValue(self.COUNT, n)
        self.setOutputValue(self.NO_DATA_COUNT, nodata)
        self.setOutputValue(self.MIN, minvalue)
        self.setOutputValue(self.MAX, maxvalue)
        self.setOutputValue(self.SUM, sum)
        self.setOutputValue(self.MEAN, mean)
        self.setOutputValue(self.STD_DEV, stddev)

    def createHTML(self, outputFile, algData):
        with codecs.open(outputFile, 'w', encoding='utf-8') as f:
            f.write('<html><head>')
            f.write('<meta http-equiv="Content-Type" content="text/html; \
                    charset=utf-8" /></head><body>')
            for s in algData:
                f.write('<p>' + str(s) + '</p>')
            f.write('</body></html>')
