%% build BIDS structure
%  cfgBIDS is a struct that must contain
%  cfgBIDS.proj_dir             - output folder where to save the imported bids
%                                 file
%  cfgBIDS.source_dir           - input folder from where to read the
%                                 original micromed (.TRC) files 
%                                 (i.e. /source/PATXX/EEG_YYYY.TRC)
%  cfgBIDS.toImportList         - filename with the table with
%                                 the PAT (micromed style) code to import
%  cfgBIDS.already_imported_dir - directory where to find the table which
%                                 keeps tracks of the imported subjects
% 

%% converting into bids structure
function bids_pipeline(cfgBIDS)

check_input(cfgBIDS,'proj_dir')
check_input(cfgBIDS,'source_dir')
check_input(cfgBIDS,'already_imported_dir')
check_input(cfgBIDS,'toImportList')



source_dir           = cfgBIDS.source_dir               ;
proj_dir             = cfgBIDS.proj_dir                 ; 
already_imported_dir = cfgBIDS.already_imported_dir     ;
toImportList         = cfgBIDS.toImportList             ;


imported_F    = fullfile(already_imported_dir,'imported.tsv');
varImported_T = {'nameTRC','nameRESP','status_ok','status_description'};

pat_dirList  = dir(fullfile(source_dir,'PAT*'))  ;



imported_T = [];

% skip subjects not in the import file list

list2importT = readtable(toImportList, 'Delimiter', 'tab', 'FileType', 'text', 'ReadVariableNames', true);

micromedCode = list2importT.micromed;

idx2Keep     = false(numel(pat_dirList),1);
for i = 1 : numel(pat_dirList)
    
    if(any(strcmp(pat_dirList(i).name,micromedCode)))
    
        idx2Keep(i) = 1;
    
    end
end
pat_dirList(~idx2Keep) = [];


for i=1:numel(pat_dirList)
    
    curr_pat_dir = fullfile(pat_dirList(i).folder,pat_dirList(i).name);
    
    
    trcFileList  = dir(fullfile(curr_pat_dir,'*.TRC'));
    
    curr_TRC_Sit = {trcFileList(:).name}'              ;
    idx_sit2skip = logical(zeros(size(trcFileList)))   ;
    
    if(exist(imported_F,'file'))
    
        imported_T   = readtable(imported_F, 'Delimiter', 'tab', 'FileType', 'text', 'ReadVariableNames', true);
        idx_imported = strcmp(imported_T.status_ok,'ok')                                                          ;
    
        trc_sit_names     = imported_T.nameTRCsit(idx_imported)                                                        ;
    
        for p=1:size(trc_sit_names,1)

            c_sitName    = deblank(trc_sit_names {p})                   ;
            idx_sit2skip = idx_sit2skip | strcmp(c_sitName,curr_TRC_Sit);
        end
    
    end
    
    trcFileList(idx_sit2skip) = [];
       
    
    for f=1:numel(trcFileList)
       
        filename     = fullfile(curr_pat_dir,trcFileList(f).name);
        cfg          = [];
        cfg.filename = filename;
        cfg.proj_dir = proj_dir;
        
        [status,msg,output] = annotatedTRC2bids(cfg);
       
        [~,nameTRC,~] = fileparts(curr_pat_dir)   ;
        nameTRC       = {nameTRC}                 ;
        nameRESP      = {output.subjName}         ;
        nameTRCsit    = {trcFileList(f).name}     ;
        nameRESPsit   = {output.sitName}          ;
        
        if (status ~= 0)
            status_ok     = {'fail'}   ;
            status_des    = {msg}      ;
        else
            status_ok     = {'ok'}     ;
            status_des    = {'ok'}     ;
        end
        
        %add the subject to the imported table
        if(isempty(imported_T)) %first time    
            imported_T = table(nameTRC,nameTRCsit,nameRESP,nameRESPsit,status_ok,status_des);
        else
            %look if the situation is present 
            trc_sit    = imported_T.nameTRCsit      ; 
            idx_row    = strcmp(nameTRCsit,trc_sit) ; 
            if(any(idx_row))
                imported_T(idx_row,:) = {nameTRC,nameTRCsit,nameRESP,nameRESPsit,status_ok,status_des};
            else
                imported_T = [imported_T ; {nameTRC,nameTRCsit,nameRESP,nameRESPsit,status_ok,status_des}];
            end
        end
        
       
    end
    writetable(imported_T, fullfile(cfgBIDS.already_imported_dir,'imported.tsv'), 'Delimiter', 'tab', 'FileType', 'text');

end


%% check if the configuration struct contains all the required fields
function check_input(cfg,key)

if (isa(cfg, 'struct')) 
  
  fn = fieldnames(cfg);
  if ~any(strcmp(key, fn))
       
    error('Provide the configuration struct with all the fields example: cfg.proj_dir  cfg.filename  error: %s missing ', key);
  end
  
else
    error('Provide the configuration struct with all the fields example: cfg.proj_dir  cfg.filename');
end
  