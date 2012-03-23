import Translater

class Jtrans(Translater):

    def __init__(self):
        pass

    def actionPerformed(self, event):
        print("Button clicked. Got event:")
        print(event)

    def setDYPL( self, obj ):
        print("Got a DYPL instance: ")
        print(obj)

if __name__ == '__main__':
    import DYPL
    DYPL(Jtrans())
