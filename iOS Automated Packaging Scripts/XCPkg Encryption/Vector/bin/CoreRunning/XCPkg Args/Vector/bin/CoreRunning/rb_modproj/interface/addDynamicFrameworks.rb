
def addDynamicFrameworks(project, target, group_name, frameworks)
    require File.dirname(__FILE__)+'/../lib/xcodeproj'
    
    proj = Xcodeproj::Project.open(project)
    targetNode = proj.targets.first
    if proj.targets.first.name != target then
        for i in proj.targets
            if i.name == target then
                targetNode = i
                break
            end
        end
    end
    
    group = proj.main_group.find_subpath(File.join(group_name), true)
    group.set_source_tree('SOURCE_ROOT')
    frameworkArray = frameworks.split(',')
    
    #添加CopyBuildPhase
    copyBuildPhase = targetNode.new_copy_files_build_phase('Embed Frameworks')
    copyBuildPhase.symbol_dst_subfolder_spec=(:frameworks)
    
    for framework in frameworkArray
        # 检测framework是否存在
        frameworkName = File.basename(framework)
        isExist = false
        for frameworkExist in targetNode.frameworks_build_phases.file_display_names
            if frameworkExist == frameworkName then
                isExist = true
                break
            end
        end
        if not isExist then
            file_ref = group.new_reference(framework, 'SOURCE_ROOT')
            targetNode.frameworks_build_phases.add_file_reference(file_ref)
            
            buildfile = copyBuildPhase.add_file_reference(file_ref, true);
            attr = ['CodeSignOnCopy', 'RemoveHeadersOnCopy'];
            
            buildfile.settings = {'ATTRIBUTES' => attr}
        end
    end
    
    #添加framework search path
    frameworkSearchPaths = targetNode.build_configuration_list.get_setting('FRAMEWORK_SEARCH_PATHS')
    frameworkPath = '"' << File.expand_path("..",framework) << '"'
    releaseFrameworkSearch = ''
    if frameworkSearchPaths['Release'] then
        releaseFrameworkSearch = frameworkSearchPaths['Release']
    end
    if releaseFrameworkSearch == '' then
        releaseFrameworkSearch = frameworkPath
    else
        releaseFrameworkSearch << ' ' << frameworkPath
    end
    targetNode.build_configuration_list.set_setting('FRAMEWORK_SEARCH_PATHS', releaseFrameworkSearch)
    
    #添加动态库的runpath search path
    runPaths = targetNode.build_configuration_list.get_setting('LD_RUNPATH_SEARCH_PATHS')
    releasePath = ''
    if runPaths['Release'] then
        releasePath = runPaths['Release']
    end
    if releasePath == '' then
        releasePath = '@executable_path/Frameworks'
    else
        releasePath << ' @executable_path/Frameworks'
    end
    
    targetNode.build_configuration_list.set_setting('LD_RUNPATH_SEARCH_PATHS', releasePath)
    
    
    proj.save
end

addDynamicFrameworks(ARGV[0], ARGV[1], ARGV[2], ARGV[3])
