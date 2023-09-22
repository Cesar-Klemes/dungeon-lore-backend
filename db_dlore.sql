CREATE DATABASE db_dlore;
USE db_dlore;


CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    encrypted_password VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    last_login_date DATETIME,
    bio TEXT,
    avatar_url VARCHAR(255),
    status VARCHAR(50)
);

CREATE TABLE race (
    race_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    movement_speed INT
);

CREATE TABLE class (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    hit_dice VARCHAR(10)
);

CREATE TABLE features (
    feature_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    required_level INT,
    uses_quantity INT
);

CREATE TABLE attributes (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE languages (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50),
    alphabet VARCHAR(50)
);


CREATE TABLE equipment_type (
    equipment_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE property_equipment (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE magic_item (
    magic_item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    type VARCHAR(50),
    rarity VARCHAR(50)
);

CREATE TABLE spells (
    spell_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    level INT,
    casting_time VARCHAR(255),
    reach VARCHAR(255),
    component_v BOOLEAN,
    component_s BOOLEAN,
    component_c BOOLEAN,
    concentration BOOLEAN,
    duration VARCHAR(255),
    school VARCHAR(255)
);

CREATE TABLE talent (
    talent_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    prerequisite TEXT,
    benefits TEXT
);

CREATE TABLE background (
    background_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);


CREATE TABLE user_settings (
    settings_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    theme VARCHAR(50),
    notifications BOOLEAN,
    language VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE sub_race (
    subrace_id INT AUTO_INCREMENT PRIMARY KEY,
    race_id INT,
    name VARCHAR(255),
    description TEXT,
    FOREIGN KEY (race_id) REFERENCES race(race_id)
);

CREATE TABLE characters (
    character_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    race_id INT,
    subrace_id INT,
    class_id INT,
    multiclass_id INT,
    name VARCHAR(255) NOT NULL,
    level INT,
    hp INT,
    exp INT,
    backstory TEXT,
    img_url VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (race_id) REFERENCES race(race_id),
    FOREIGN KEY (subrace_id) REFERENCES sub_race(subrace_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id),
    FOREIGN KEY (multiclass_id) REFERENCES class(class_id)
);

CREATE TABLE game_table (
    table_id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at DATE,
    updated_at DATE,
    status VARCHAR(50),
    FOREIGN KEY (master_id) REFERENCES user(user_id)
);

CREATE TABLE table_npc (
    npc_id INT AUTO_INCREMENT PRIMARY KEY,
    master_id INT,
    table_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    type VARCHAR(50),
    challenge_level VARCHAR(50),
    hp INT,
    ac INT,
    traits TEXT,
    actions TEXT,
    reactions TEXT,
    legendaries TEXT,
    img_url VARCHAR(255),
    FOREIGN KEY (master_id) REFERENCES user(user_id),
    FOREIGN KEY (table_id) REFERENCES game_table(table_id)
);

CREATE TABLE npc_attribute (
    npc_id INT,
    attribute_id INT,
    value INT,
    PRIMARY KEY (npc_id, attribute_id),
    FOREIGN KEY (npc_id) REFERENCES table_npc(npc_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);

CREATE TABLE table_players (
    table_id INT,
    player_id INT,
    PRIMARY KEY (table_id, player_id),
    FOREIGN KEY (table_id) REFERENCES game_table(table_id),
    FOREIGN KEY (player_id) REFERENCES user(user_id)
);

CREATE TABLE table_characters (
    table_id INT,
    character_id INT,
    PRIMARY KEY (table_id, character_id),
    FOREIGN KEY (table_id) REFERENCES game_table(table_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id)
);

CREATE TABLE equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_type_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    armor_class INT,
    damage VARCHAR(255),
    damage_type VARCHAR(255),
    weight FLOAT,
    strength_requirement INT,
    gold_value FLOAT,
    FOREIGN KEY (equipment_type_id) REFERENCES equipment_type(equipment_type_id)
);

CREATE TABLE character_equipments (
    character_id INT,
    equipment_id INT,
    PRIMARY KEY (character_id, equipment_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
);

CREATE TABLE character_spells (
    character_id INT,
    spell_id INT,
    PRIMARY KEY (character_id, spell_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id),
    FOREIGN KEY (spell_id) REFERENCES spells(spell_id)
);

CREATE TABLE character_talents (
    character_id INT,
    talent_id INT,
    PRIMARY KEY (character_id, talent_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id),
    FOREIGN KEY (talent_id) REFERENCES talent(talent_id)
);

CREATE TABLE character_attributes (
    character_id INT,
    attribute_id INT,
    value INT,
    PRIMARY KEY (character_id, attribute_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);


CREATE TABLE character_features (
    character_id INT,
    feature_id INT,
    PRIMARY KEY (character_id, feature_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id),
    FOREIGN KEY (feature_id) REFERENCES features(feature_id)
);

CREATE TABLE character_magic_items (
    character_id INT,
    magic_item_id INT,
    quantity INT,
    acquisition_date DATE,
    status VARCHAR(255),
    PRIMARY KEY (character_id, magic_item_id),
    FOREIGN KEY (character_id) REFERENCES characters(character_id),
    FOREIGN KEY (magic_item_id) REFERENCES magic_item(magic_item_id)
);

CREATE TABLE skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    attribute_id INT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);

CREATE TABLE equipment_properties (
    equipment_id INT,
    property_id INT,
    PRIMARY KEY (equipment_id, property_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (property_id) REFERENCES property_equipment(property_id)
);

CREATE TABLE mod_equip_attribute (
    equipment_id INT,
    attribute_id INT,
    modifier INT NOT NULL,
    PRIMARY KEY (equipment_id, attribute_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);

CREATE TABLE mod_equip_skills (
    equipment_id INT,
    skill_id INT,
    modifier INT NOT NULL,
    PRIMARY KEY (equipment_id, skill_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE class_equipment_type_proficiency (
    class_id INT,
    equipment_type_id INT,
    PRIMARY KEY (class_id, equipment_type_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id),
    FOREIGN KEY (equipment_type_id) REFERENCES equipment_type(equipment_type_id)
);

CREATE TABLE class_spell (
    class_id INT,
    spell_id INT,
    PRIMARY KEY (class_id, spell_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id),
    FOREIGN KEY (spell_id) REFERENCES spells(spell_id)
);

CREATE TABLE class_bonus_proficiency (
    bonus_proficiency_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT,
    bonus INT,
    level INT,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
);

CREATE TABLE class_saving_throw_proficiency (
    class_id INT,
    attribute_id INT,
    PRIMARY KEY (class_id, attribute_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);

CREATE TABLE class_features (
    class_id INT,
    feature_id INT,
    PRIMARY KEY (class_id, feature_id),
    FOREIGN KEY (class_id) REFERENCES class(class_id),
    FOREIGN KEY (feature_id) REFERENCES features(feature_id)
);

CREATE TABLE race_features (
    race_id INT,
    feature_id INT,
    PRIMARY KEY (race_id, feature_id),
    FOREIGN KEY (race_id) REFERENCES race(race_id),
    FOREIGN KEY (feature_id) REFERENCES features(feature_id)
);

CREATE TABLE race_languages (
    race_id INT,
    language_id INT,
    PRIMARY KEY (race_id, language_id),
    FOREIGN KEY (race_id) REFERENCES race(race_id),
    FOREIGN KEY (language_id) REFERENCES languages(language_id)
);

CREATE TABLE race_attribute_bonus (
    race_id INT,
    attribute_id INT,
    bonus INT,
    PRIMARY KEY (race_id, attribute_id),
    FOREIGN KEY (race_id) REFERENCES race(race_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);

CREATE TABLE subrace_attribute_bonus (
    subrace_id INT,
    attribute_id INT,
    bonus INT,
    PRIMARY KEY (subrace_id, attribute_id),
    FOREIGN KEY (subrace_id) REFERENCES sub_race(subrace_id),
    FOREIGN KEY (attribute_id) REFERENCES attributes(attribute_id)
);

CREATE TABLE activatable_property (
    property_id INT AUTO_INCREMENT PRIMARY KEY,
    magic_item_id INT,
    description TEXT,
    limited_use BOOLEAN,
    uses_remaining INT,
    FOREIGN KEY (magic_item_id) REFERENCES magic_item(magic_item_id)
);

CREATE TABLE prerequisite_item (
    prerequisite_id INT AUTO_INCREMENT PRIMARY KEY,
    magic_item_id INT,
    description TEXT,
    FOREIGN KEY (magic_item_id) REFERENCES magic_item(magic_item_id)
);

CREATE TABLE curse (
    curse_id INT AUTO_INCREMENT PRIMARY KEY,
    magic_item_id INT,
    description TEXT,
    FOREIGN KEY (magic_item_id) REFERENCES magic_item(magic_item_id)
);

CREATE TABLE temporary_effect (
    effect_id INT AUTO_INCREMENT PRIMARY KEY,
    magic_item_id INT,
    description TEXT,
    duration VARCHAR(255),
    FOREIGN KEY (magic_item_id) REFERENCES magic_item(magic_item_id)
);

CREATE TABLE background_features (
    background_id INT,
    features_id INT,
    PRIMARY KEY (background_id, features_id),
    FOREIGN KEY (background_id) REFERENCES background(background_id),
    FOREIGN KEY (features_id) REFERENCES features(feature_id)
);

CREATE TABLE background_languages (
    background_id INT,
    language_id INT,
    PRIMARY KEY (background_id, language_id),
    FOREIGN KEY (background_id) REFERENCES background(background_id),
    FOREIGN KEY (language_id) REFERENCES languages(language_id)
);

CREATE TABLE background_skills (
    background_id INT,
    skill_id INT,
    PRIMARY KEY (background_id, skill_id),
    FOREIGN KEY (background_id) REFERENCES background(background_id),
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
);

CREATE TABLE background_starting_equipment (
    equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    background_id INT,
    equipment_list TEXT,
    FOREIGN KEY (background_id) REFERENCES background(background_id)
);
