/************************************************************************
 * This file has been generated automatically from                      *
 *                                                                      *
 * src/gui/qgscolordialog.h                                             *
 *                                                                      *
 * Do not edit manually ! Edit header and run scripts/sipify.pl again   *
 ************************************************************************/





class QgsColorDialog : QDialog
{
%Docstring
 A custom QGIS dialog for selecting a color. Has many improvements over the standard Qt color picker dialog, including
 hue wheel supports, color swatches, and a color sampler.
.. versionadded:: 2.5
%End

%TypeHeaderCode
#include "qgscolordialog.h"
%End
  public:

    QgsColorDialog( QWidget *parent /TransferThis/ = 0, Qt::WindowFlags fl = QgsGuiUtils::ModalDialogFlags,
                    const QColor &color = QColor() );
%Docstring
 Create a new color picker dialog
 \param parent parent widget
 \param fl window flags
 \param color initial color for dialog
%End

    QColor color() const;
%Docstring
 Returns the current color for the dialog
 :return: dialog color
 :rtype: QColor
%End

    void setTitle( const QString &title );
%Docstring
 Sets the title for the color dialog
 \param title title for dialog box
%End

    void setAllowAlpha( const bool allowAlpha );
%Docstring
 Sets whether alpha modification (transparency) is permitted
 for the color dialog. Defaults to true.
 \param allowAlpha set to false to disable alpha modification
%End

    static QColor getLiveColor( const QColor &initialColor, QObject *updateObject, const char *updateSlot,
                                QWidget *parent = 0,
                                const QString &title = QString(),
                                const bool allowAlpha = true );
%Docstring
 Return a color selection from a color dialog, with live updating of interim selections.
 \param initialColor the initial color of the selection dialog.
 \param updateObject the receiver object of the live updating.
 \param updateSlot the receiver object's slot for live updating (e.g. SLOT( setValidColor( const QColor& ) ) ).
 \param parent parent widget
 \param title the title of the dialog.
 \param allowAlpha set to true to allow modification of color alpha value (transparency)
 :return: Selected color on accepted() or initialColor on rejected().
.. seealso:: getColor
 :rtype: QColor
%End

    static QColor getColor( const QColor &initialColor, QWidget *parent, const QString &title = QString(),
                            const bool allowAlpha = false );
%Docstring
 Return a color selection from a color dialog.
 \param initialColor the initial color of the selection dialog.
 \param parent parent widget
 \param title the title of the dialog.
 \param allowAlpha set to true to allow modification of color alpha value (transparency)
 :return: Selected color on accepted() or initialColor on rejected().
.. seealso:: getLiveColor
 :rtype: QColor
%End

  signals:

    void currentColorChanged( const QColor &color );
%Docstring
 Emitted when the dialog's color changes
 \param color current color
%End

  public slots:

    void setColor( const QColor &color );
%Docstring
 Sets the current color for the dialog
 \param color desired color
%End

  protected:

    virtual void closeEvent( QCloseEvent *e );


};

/************************************************************************
 * This file has been generated automatically from                      *
 *                                                                      *
 * src/gui/qgscolordialog.h                                             *
 *                                                                      *
 * Do not edit manually ! Edit header and run scripts/sipify.pl again   *
 ************************************************************************/
