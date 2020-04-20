
% run bids pipeline
%cfgBIDS                      = []                                             ;
%cfgBIDS.source_dir           = '/home/matteo/Desktop/BIDS/RESPECT/source/'    ;
%cfgBIDS.proj_dir             = '/home/matteo/Desktop/BIDS/RESPECT/converted/' ; 
%cfgBIDS.already_imported_dir = '/home/matteo/Desktop/BIDS/RESPECT/info/'      ; 



%% temporal 12/03/2019
%  cfgBIDS                      = []                                                                 ;
%  cfgBIDS.source_dir           = '/home/matteo/Desktop/acute_sel/'                                  ;
%  cfgBIDS.proj_dir             = '/home/matteo/Desktop/tle/converted2/'                             ;  
%  cfgBIDS.already_imported_dir = '/home/matteo/Desktop/tle/info/'                                   ; 
%  cfgBIDS.toImportList         = '/home/matteo/Desktop/tle/info/tle_info.tsv'                       ;
 
% bids_pipeline(cfgBIDS);


%% extra temporal 21/02/2019
%cfgBIDS                      = []                                                                           ;
%cfgBIDS.source_dir           = '/home/matteo/Desktop/acute_sel/'                                            ;
%cfgBIDS.proj_dir             = '/home/matteo/Desktop/extra_temporal/converted/'                             ;  
%cfgBIDS.already_imported_dir = '/home/matteo/Desktop/extra_temporal/info/'                                  ; 
%cfgBIDS.toImportList         = '/home/matteo/Desktop/extra_temporal/info/resp_pat_extratemporal.tsv'        ;




%% extra temporal import 01/08/2019
%cfgBIDS                      = []                                                                            ;
%cfgBIDS.source_dir           = '/home/matteo/Desktop/acute_sel/'                                             ;
%cfgBIDS.proj_dir             = '/home/matteo/Desktop/extra_temporal_noHFOtrial/converted2/'                   ;  
%cfgBIDS.already_imported_dir = '/home/matteo/Desktop/extra_temporal_noHFOtrial/info/'                        ; 
%cfgBIDS.toImportList         = '/home/matteo/Desktop/extra_temporal_noHFOtrial/info/resp_pat_noHFOtrial.tsv' ;



%% try import all 16/10/2019
%cfgBIDS                      = []                                                                            ;
%cfgBIDS.source_dir           = '/home/matteo/Desktop/acute_sel/'                                             ;
%cfgBIDS.proj_dir             = '/home/matteo/Desktop/import_all/converted/'                   ;  
%cfgBIDS.already_imported_dir = '/home/matteo/Desktop/import_all/info/'                        ; 
%cfgBIDS.toImportList         = '/home/matteo/Desktop/import_all/info/micromed_code.tsv' ;


% try import all new BIDS 16/04/2020
cfgBIDS                      = []                                                                            ;
cfgBIDS.source_dir           = '/home/matteo/Desktop/acute/'                                             ;
cfgBIDS.proj_dir             = '/home/matteo/Desktop/new_BIDS_import/converted/'                   ;  
cfgBIDS.already_imported_dir = '/home/matteo/Desktop/new_BIDS_import/info/'                        ; 
cfgBIDS.toImportList         = '/home/matteo/Desktop/new_BIDS_import/info/micromed_code.tsv' ;




bids_pipeline(cfgBIDS);