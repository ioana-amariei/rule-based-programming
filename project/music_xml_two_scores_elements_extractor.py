import xml.etree.ElementTree as ET
import sys


if len(sys.argv) < 3 or len(sys.argv) > 3:
    raise TypeError


music_xml_file_1 = sys.argv[1]
music_xml_file_2 = sys.argv[2]


def xml_to_dictionary(path):
    tree = ET.parse(path)
    return tree.getroot()


def create_measure_template(path):
    f = open(path, "a+")

    f.write("(deftemplate measure\n")
    f.write("\t(slot id)\n")
    f.write("\t(slot score_id)\n")
    f.write("\t(multislot notes_id)\n")
    f.write(")\n\n")

    f.close()


def create_note_template(path):
    f = open(path, "a+")

    f.write("(deftemplate note\n")
    f.write("\t(slot id)\n")
    f.write("\t(slot measure_id)\n")
    f.write("\t(slot score_id)\n")
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
    for measure in root_1.findall('.//measure'):
        id = measure.attrib.get('number')
        f.write("\t(measure " + "(id " + id + ") "
                + "(score_id S1) "
                + "(notes_id " + get_measure_notes_id_as_string(measure) + ") "
                + ")\n")

    for measure in root_2.findall('.//measure'):
        id = measure.attrib.get('number')
        f.write("\t(measure " + "(id " + id + ") "
                + "(score_id S2) "
                + "(notes_id " + get_measure_notes_id_as_string(measure) + ") "
                + ")\n")
    f.write(")\n\n")

    # then we define notes
    f.write("(deffacts notes\n")
    for measure in root_1.findall('.//measure'):
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
					+ "(score_id S1) "
                    + "(pitch " + pitch[0] + " " + pitch[1] + ") "
                    + "(duration " + duration + ") "
                    + "(voice " + voice + ") "
                    + "(type " + type + ") "
                    + "(stem " + stem + ") "
                    + ")\n")
            count += 1

    for measure in root_2.findall('.//measure'):
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
					+ "(score_id S2) "
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


def erase_file_previous_content(file):
    open(file, 'w').close()


root_1 = xml_to_dictionary(music_xml_file_1)
root_2 = xml_to_dictionary(music_xml_file_2)
clips_file = "clips/music-facts.clp"

erase_file_previous_content(clips_file)

create_note_template(clips_file)
create_measure_template(clips_file)
create_knowledge_base(clips_file)
