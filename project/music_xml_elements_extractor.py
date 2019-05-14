import xml.etree.ElementTree as ET


def xml_to_dictionary(path):
    tree = ET.parse(path)
    return tree.getroot()


def get_measures(root):
    return root.findall('.//measure')


def get_musical_notes(root):
    notes = []

    for note in root.iter('note'):
        notes.append(note)

    return notes


def create_measure_template(path):
    f = open(path, "a+")

    f.write("(deftemplate measure\n")
    f.write("\t(slot number)\n")
    f.write("\t(slot width)\n")
    f.write(")\n\n")

    f.close()


def create_note_template(path):
    f = open(path, "a+")

    f.write("(deftemplate note\n")
    f.write("\t(multislot position)\n")
    f.write("\t(multislot pitch)\n")
    f.write("\t(slot duration)\n")
    f.write("\t(slot voice)\n")
    f.write("\t(slot type)\n")
    f.write("\t(slot stem)\n")
    f.write(")\n\n")

    f.close()


def create_notes_knowledge_base(path, notes, measures):
    f = open(path, "a+")

    f.write("(deffacts notes\n")
    for note in notes:
        f.write("\t(note "
                + "(position " + note.attrib.get('default-x') + " " + note.attrib.get('default-x') + ") "
                + "(pitch " + note.find('pitch').find('step').text + " " + note.find('pitch').find('octave').text + ") "
                + "(duration " + note.find('duration').text + ") "
                + "(voice " + note.find('voice').text + ") "
                + "(type " + note.find('type').text + ") "
                + "(stem " + note.find('stem').text + ") "
                + ")\n")
    f.write(")\n\n")

    f.write("(deffacts measures\n")
    for measure in measures:
        f.write("\t(measure "
                + "(number " + measure.attrib.get('number') + ") "
                + "(width " + measure.attrib.get('width') + ") "
                + ")\n")
    f.write(")\n\n")

    f.close()


music_xml_file = "violin-music/Game_Of_Thrones_-_Main_Theme_Violin.musicxml"
root = xml_to_dictionary(music_xml_file)

notes = get_musical_notes(root)
measures = get_measures(root)

clips_file = "notes.clp"
create_note_template(clips_file)
create_measure_template(clips_file)
create_notes_knowledge_base(clips_file, notes, measures)


