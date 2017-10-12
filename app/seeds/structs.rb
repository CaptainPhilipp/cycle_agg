# frozen_string_literal: true

Group           = Struct.new :en_title, :ru_title
Section         = Struct.new :depth, :en_title, :ru_title, :parents
Subsection      = Struct.new :depth, :en_title, :ru_title, :parents
ParameterStruct = Struct.new :en_title, :ru_title, :values_type, :parents
ListValueStruct = Struct.new :en_title, :ru_title, :parents
SynonymStruct   = Struct.new :value, :owner
