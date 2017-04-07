function crm = tbx_scfg_hmri_crm
% Configuration file for the "histological MRI" (hMRI) toolbox
% Previously named "Voxel-Based Quantification" (VBQ)
% -> Dealing with the creation of the maps
%_______________________________________________________________________
% Copyright (C) 2014 Wellcome Trust Centre for Neuroimaging

% Christophe Phillips

b1_choices = hmri_get_defaults('b1_type.labels');

% ---------------------------------------------------------------------
% raws Raw Images
% ---------------------------------------------------------------------
raws3           = cfg_files;
raws3.tag       = 'T1';
raws3.name      = 'T1 images';
raws3.help      = {'Input T1 images.'};
raws3.filter    = 'image';
raws3.ufilter   = '.*';
raws3.num       = [0 Inf];
raws3.val       = {''};
% ---------------------------------------------------------------------
% raws Raw Images
% ---------------------------------------------------------------------
raws2           = cfg_files;
raws2.tag       = 'PD';
raws2.name      = 'PD images';
raws2.help      = {'Input PD images.'};
raws2.filter    = 'image';
raws2.ufilter   = '.*';
raws2.num       = [0 Inf];
raws2.val       = {''};
% ---------------------------------------------------------------------
% raws Raw Images
% ---------------------------------------------------------------------
raws1           = cfg_files;
raws1.tag       = 'MT';
raws1.name      = 'MT images';
raws1.help      = {'Input MT images.'};
raws1.filter    = 'image';
raws1.ufilter   = '.*';
raws1.num       = [0 Inf];
raws1.val       = {''};
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
raws            = cfg_branch;
raws.tag        = 'raw_mpm';
raws.name       = 'Raw multiparameter data';
raws.help       = {'Input all the MT/PD/T1-weighted images.'};
raws.val        = {raws1 raws2 raws3 };
% ---------------------------------------------------------------------
% menu type_b1
% ---------------------------------------------------------------------
b1_type         = cfg_menu;
b1_type.tag     = 'b1_type';
b1_type.name    = 'Choose the B1map type';
b1_type.help    = {
    ['Various B1map types can be handled by the hMRI ', ...
    'toolbox when creating the multiparameter maps. See list below for a ', ...
    'brief description of each type. Note that all types may not be ', ...
    'available at your site.']...
    [' - i3D_EPI: B1map obtained from spin echo (SE) and stimulated echo ', ...
    '(STE) images recorded with a 3D EPI scheme [Jiru F, Klose U, ', ...
    'Magn Reson Med 2006;56:1375�1379].'] ...
    [' - i3D_AFI: 3D actual flip angle imaging (AFI) method based on [Yarnykh VL, ', ...
    'Magn Reson Med 2007;57:192�200].'] ...
    [' - tfl_b1_map'] ...
    [' - rf_map'] ...
    [' - no_B1_correction: if selected no B1 bias correction will be applied.'] ...
    [' - pre_processed_B1: B1 map pre-calculated out of the hMRI toolbox, must ', ...
    'be expressed in percent units of the nominal flip angle value (percent bias).'] ...
    [' - UNICORT: Use this option when B1 maps not available. ', ...
    'Bias field estimation and correction will be performed', ...
    'using the approach described in [Weiskopf et al., NeuroImage 2011; 54:2116�2124].']
    };
b1_type.labels  = b1_choices;
b1_type.values = b1_choices;
b1_type.val    = b1_choices(1);
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
braws2          = cfg_files;
braws2.tag      = 'b1';
braws2.name     = 'B1 images';
braws2.help     = {
    'Select B1 images if available.' ...
    ' - i3D_EPI: select all pairs of SE/STE images.' ...
    ' - i3D_AFI: select a TR2/TR1 pair of magnitude images.' ...
    ' - tfl_b1_map' ...
    ' - rf_map' ...
    ' - no_B1_correction: no B1 image required.' ...
    [' - pre_processed_B1: select one unprocessed magnitude image from ', ...
    'the B1map data set (for coregistration with the multiparameter maps) and ', ...
    'the preprocessed B1map (in percent units), in that order.'] ...
    ' - UNICORT: no B1 image required.' ...
    };
braws2.filter   = 'image';
braws2.ufilter  = '.*';
braws2.num      = [0 30];
braws2.val      = {''};
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
braws1          = cfg_files;
braws1.tag      = 'b0';
braws1.name     = 'B0 images';
braws1.help     = {'Select B0 images.' ...
    'Only required for distortion correction of EPI-based B1 maps.' ...
    'Select both magnitude images and the presubtracted phase image, in that order.'};
braws1.filter   = 'image';
braws1.ufilter  = '.*';
braws1.num      = [0 3];
braws1.val      = {''};
% ---------------------------------------------------------------------
% vols Volumes
% ---------------------------------------------------------------------
braws           = cfg_branch;
braws.tag       = 'raw_fld';
braws.name      = 'Raw B0 & B1 data';
braws.help      = {'Input all B0 & B1 images required to create the multiparameter maps.'};
braws.val       = {braws1 braws2};
% ---------------------------------------------------------------------
% subj Subject
% ---------------------------------------------------------------------
subj            = cfg_branch;
subj.tag        = 'subj';
subj.name       = 'Subject';
subj.val        = {braws raws };
subj.help       = {'Specify a subject for maps calculation.'};
% ---------------------------------------------------------------------
% data Data
% ---------------------------------------------------------------------
sdata           = cfg_repeat;
sdata.tag       = 'data';
sdata.name      = 'Few Subjects';
sdata.val       = {subj };
sdata.help      = {'Specify the number of subjects.'};
sdata.values    = {subj };
sdata.num       = [1 Inf];
% ---------------------------------------------------------------------
% indir Input directory as output directory
% ---------------------------------------------------------------------
indir         = cfg_menu;
indir.tag     = 'indir';
indir.name    = 'Input directory';
indir.help    = {'Output files will be written to the same folder as each ',...
    'corresponding input file.'};
indir.labels = {'Yes'};
indir.values = {1};
indir.val = {1};
% ---------------------------------------------------------------------
% outdir Output directory
% ---------------------------------------------------------------------
outdir         = cfg_files;
outdir.tag     = 'outdir';
outdir.name    = 'Output directory';
outdir.help    = {'Select a directory where output files will be written to.'};
outdir.filter = 'dir';
outdir.ufilter = '.*';
outdir.num     = [1 1];
% ---------------------------------------------------------------------
% output Output choice
% ---------------------------------------------------------------------
output         = cfg_choice;
output.tag     = 'output';
output.name    = 'Output choice';
output.help    = {'Output directory can be the same as the input ',...
    'directory for each input file or user selected'};
output.values  = {indir outdir };
output.val = {indir};
% ---------------------------------------------------------------------
% sdata_multi
% ---------------------------------------------------------------------
sdata_multi = cfg_branch;
sdata_multi.name = 'Many Subjects';
sdata_multi.tag = 'sdata_multi';
sdata_multi.help = {'Specify data with many subjects.'};
% ---------------------------------------------------------------------
% data_spec
% ---------------------------------------------------------------------
data_spec = cfg_choice;
data_spec.name = 'Data Specification Method';
data_spec.tag = 'data_spec';
data_spec.values = { sdata sdata_multi };
data_spec.val = { sdata };
data_spec.help = {'Specify data with either few or many subjects. The ',...
    'latter can be used with SmartDep toolbox.'};
% ---------------------------------------------------------------------
% create_mpr Create MPR maps (whether B0/B1 maps are available or not)
% ---------------------------------------------------------------------
create_mpr         = cfg_exbranch;
create_mpr.tag     = 'create_mpr';
create_mpr.name    = 'Multiparameter maps';
raws.val        = {raws1 raws2 raws3 };
braws.val       = {braws1 braws2};
subj.val        = {output b1_type braws raws};
sdata.val       = {subj };
sdata.values    = {subj };
sdata_multi.val  = { output unlimit(braws) unlimit(raws) };
data_spec.values = { sdata sdata_multi };
data_spec.val    = { sdata };
create_mpr.val     = { data_spec };
create_mpr.help    = {'hMRI map creation can handle data sets with and without B0/B1 maps.'};
create_mpr.prog    = @hmri_run_mpr;
create_mpr.vout    = @vout_create_mpr;
% ---------------------------------------------------------------------
% crm Create maps
% ---------------------------------------------------------------------
crm             = cfg_choice;
crm.tag         = 'crm';
crm.name        = 'Create maps';
crm.help        = {'You have the option to create multiparameter maps, ',...
    'whether B1 maps are available or not.'};
crm.values      = {create_mpr};

end
%----------------------------------------------------------------------

% ========================================================================
%% VOUT & OTHER SUBFUNCTIONS
% ========================================================================
% The RUN functions :
% - out = hmri_run_mpr_b0_b1(job)
% - out = hmri_run_mpr_unicort(job)
% are defined separately.
%_______________________________________________________________________

function dep = vout_crt_Unicort(job)
% This depends on job contents, which may not be present when virtual
% outputs are calculated.

% job = process_data_spec(job);

if ~isfield(job, 'subj') % Many subjects
    dep(1) = cfg_dep;
    dep(1).sname = 'R1 Maps';
    dep(1).src_output = substruct('.','R1','()',{':'});
    dep(1).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(2) = cfg_dep;
    dep(2).sname = 'R1u Maps';
    dep(2).src_output = substruct('.','R1u','()',{':'});
    dep(2).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(3) = cfg_dep;
    dep(3).sname = 'R2s Maps';
    dep(3).src_output = substruct('.','R2s','()',{':'});
    dep(3).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(4) = cfg_dep;
    dep(4).sname = 'MT Maps';
    dep(4).src_output = substruct('.','MT','()',{':'});
    dep(4).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(5) = cfg_dep;
    dep(5).sname = 'A Maps';
    dep(5).src_output = substruct('.','A','()',{':'});
    dep(5).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(6) = cfg_dep;
    dep(6).sname = 'T1w Maps';
    dep(6).src_output = substruct('.','T1w','()',{':'});
    dep(6).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
else
    k=1;
    cdep(5*numel(job.subj),1) = cfg_dep;
    
    for i=1:numel(job.subj)
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('R1_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','R1','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)          = cfg_dep;
        cdep(k).sname      = sprintf('R1u_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','R1u','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('R2s_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','R2s','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('MT_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','MT','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('A_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','A','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('T1w_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','T1w','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
    end
    dep = cdep;
end

end
%_______________________________________________________________________

function dep = vout_create_mpr(job)
% This depends on job contents, which may not be present when virtual
% outputs are calculated.

if ~isfield(job, 'subj') % Many subjects
    dep(1) = cfg_dep;
    dep(1).sname = 'R1 Maps';
    dep(1).src_output = substruct('.','R1','()',{':'});
    dep(1).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(2) = cfg_dep;
    dep(2).sname = 'R2s Maps';
    dep(2).src_output = substruct('.','R2s','()',{':'});
    dep(2).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(3) = cfg_dep;
    dep(3).sname = 'MT Maps';
    dep(3).src_output = substruct('.','MT','()',{':'});
    dep(3).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(4) = cfg_dep;
    dep(4).sname = 'A Maps';
    dep(4).src_output = substruct('.','A','()',{':'});
    dep(4).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
    dep(5) = cfg_dep;
    dep(5).sname = 'T1w Maps';
    dep(5).src_output = substruct('.','T1w','()',{':'});
    dep(5).tgt_spec = cfg_findspec({{'filter','image','strtype','e'}});
    
else
    k=1;
    cdep(5*numel(job.subj),1) = cfg_dep;
    for i=1:numel(job.subj)
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('R1_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','R1','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('R2s_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','R2s','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('MT_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','MT','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('A_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','A','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
        
        cdep(k)            = cfg_dep;
        cdep(k).sname      = sprintf('T1w_subj%d',i);
        cdep(k).src_output = substruct('.','subj','()',{i},'.','T1w','()',{':'});
        cdep(k).tgt_spec   = cfg_findspec({{'filter','image','strtype','e'}});
        
        k=k+1;
    end
    dep = cdep;
    
end
end
%_______________________________________________________________________

function c = unlimit(c)
try
    if isa(c, 'cfg_files')
        c.num = [0 Inf];
    end
catch e %#ok<*NASGU>
end
try
    for i=1:numel(c.val)
        c.val{i} = unlimit(c.val{i});
    end
catch e
end
end

