
% Run bids_pipeline
% Import multiple TRC files organized with the Micromed folder structure
% into BIDS

%     Copyright (C) 2020 Matteo Demuru
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <https://www.gnu.org/licenses/>.

cfgBIDS                      = []                               ;
cfgBIDS.source_dir           = '/source_TRC/'                   ;% Micromed subject folder name (/PAT_XX/*.TRC)
cfgBIDS.proj_dir             = '/output_BIDS/'                  ;% output folder name where to store data in BIDS format 
cfgBIDS.already_imported_dir = '/imported.tsv'                  ;% log-file of successful/failed import
cfgBIDS.toImportList         = 'micromed_code.tsv'              ;% table with the Micromed subject name to import (PAT_XX) 



bids_pipeline(cfgBIDS);