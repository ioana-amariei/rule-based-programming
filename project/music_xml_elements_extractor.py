import xml.etree.ElementTree as ET


def xml_to_dictionary(path):
    tree = ET.parse(path)
    return tree.getroot()


def create_measure_template(path):
    f = open(path, "a+")

    f.write("(deftemplate measure\n")
    f.write("\t(slot id)\n")
    f.write("\t(multislot notes_id)\n")
    f.write(")\n\n")

    f.close()


def create_note_template(path):
    f = open(path, "a+")

    f.write("(deftemplate note\n")
    f.write("\t(slot id)\n")
    f.write("\t(slot measure_id)\n")
    f.write("\t(multislot pitch)\n")
    f.write("\t(slot duration)\n")
    f.write("\t(slot voice)\n")
    f.write("\t(slot type)\n")
    f.write("\t(slot stem)\n")
    f.write(")\n\n")

    f.close()


def get_note_duration(note):
    duration = note.find('duration')
    if duration is None:
        return "none"
    return duration.text


def get_note_voice(note):
    voice = note.find('voice')
    if voice is None:
        return "none"
    return voice.text


def get_note_type(note):
    note_type = note.find('type')
    if note_type is None:
        return "none"
    return note_type.text


def get_note_stem(note):
    stem = note.find('stem')
    if stem is None:
        return "none"
    return stem.text


def get_note_pitch(note):
    pitch = note.find('pitch')
    if pitch is None:
        return "none", "none"

    step = pitch.find('step')
    octave = pitch.find('octave')
    if step is None:
        if octave is None:
            return "none", "none"
        return "none", octave.text
    else:
        if octave is None:
            return step.text, "none"
        return step.text, octave.text


def create_knowledge_base(clips_file_path):
    f = open(clips_file_path, "a+")

    # first we define measures
    f.write("(deffacts measures\n")
    for measure in root.findall('.//measure'):
        id = measure.attrib.get('number')
        f.write("\t(measure " + "(id " + id + ") "
                + "(notes_id " + get_measure_notes_id_as_string(measure) + ") "
                + ")\n")
    f.write(")\n\n")

    # then we define notes
    f.write("(deffacts notes\n")
    for measure in root.findall('.//measure'):
        measure_id = measure.attrib.get('number')
        count = 1
        for note in measure.findall('note'):

            duration = get_note_duration(note)
            voice = get_note_voice(note)
            type = get_note_type(note)
            stem = get_note_stem(note)
            pitch = get_note_pitch(note)

            f.write("\t(note "
                    + "(id " + str(count) + ") "
                    + "(measure_id " + measure_id + ") "
                    + "(pitch " + pitch[0] + " " + pitch[1] + ") "
                    + "(duration " + duration + ") "
                    + "(voice " + voice + ") "
                    + "(type " + type + ") "
                    + "(stem " + stem + ") "
                    + ")\n")
            count += 1
    f.write(")\n\n")


def get_measure_notes_id_as_string(measure):
    count = 1
    notes_id = ""
    for note in measure.findall('note'):
        notes_id += str(count) + " "
        count += 1

    return notes_id


# must provide file with extension .musicxml
music_xml_file = "violin-music/Game_Of_Thrones_-_Main_Theme_Violin.musicxml"
root = xml_to_dictionary(music_xml_file)
clips_file = "notes.clp"

create_note_template(clips_file)
create_measure_template(clips_file)
create_knowledge_base(clips_file)
