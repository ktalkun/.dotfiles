import sys
import os
from PyQt5.Qt import QMimeData, QUrl, QApplication, QClipboard
from PyQt5.QtCore import QTimer

app = QApplication(sys.argv)
def main(argv):
    directory = os.getcwd()
    listFiles = sys.argv[1:]
    files = []
    for str in listFiles:
        files.append("file://" + directory + "/"  + str)
    #print(files)
    clipboard = QApplication.clipboard()
    mimeData = QMimeData()
    mimeData.setText("x-special/nautilus-clipboard\ncopy\n" + "\n".join(files))
    qUrls = []
    for file in files:
        qUrls.append(QUrl(file))
    #clipboard.dataChanged.connect(clipboardChanged)
    mimeData.setUrls(qUrls)
    clipboard.setMimeData(mimeData, QClipboard.Clipboard)
    timer = QTimer()
    #timer.timeout.connect(clipboardChanged)
    timer.timeout.connect(lambda: None)
    timer.start(100)
    sys.exit(app.exec_())
 
def clipboardChanged():
        #print("CHNAGED")
        #print (QApplication.clipboard().text())
        sys.exit(0)

if __name__ == "__main__":
    main(sys.argv[0:])
