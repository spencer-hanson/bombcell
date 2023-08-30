function [codeLines, splitLine] = prettify_split_lines(codeLines, linesToSplit, newLineBeforeKeywords, newLineAfterKeywords, iLine)
    if contains(linesToSplit(2:end), newLineBeforeKeywords)
        for iNewLine = 1:size(newLineBeforeKeywords,2) 
            thiskey = newLineBeforeKeywords{iNewLine};
            % all possible combinations 
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ' '], [newline newLineBeforeKeywords{iNewLine} ' ']);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ' '], [',' newline newLineBeforeKeywords{iNewLine} ' ']);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ','], [',' newline newLineBeforeKeywords{iNewLine} ' ']);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ','], [newline newLineBeforeKeywords{iNewLine} ',']);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey '('], [newline newLineBeforeKeywords{iNewLine} '(']);
            linesToSplit = regexprep(linesToSplit, [',' thiskey '('], [',' newline newLineBeforeKeywords{iNewLine} '(']);
            linesToSplit = regexprep(linesToSplit, [';' thiskey '('], [';' newline newLineBeforeKeywords{iNewLine} '(']);
            linesToSplit = regexprep(linesToSplit, [';' thiskey ','], [';' newline newLineBeforeKeywords{iNewLine} ',']);
            linesToSplit = regexprep(linesToSplit, [';' thiskey ' '], [';' newline newLineBeforeKeywords{iNewLine} ' ']);
            linesToSplit = regexprep(linesToSplit, [';' thiskey ';'], [';' newline newLineBeforeKeywords{iNewLine} ';']);
            linesToSplit = regexprep(linesToSplit, [')' thiskey ';'], [')' newline newLineBeforeKeywords{iNewLine} ';']);
            linesToSplit = regexprep(linesToSplit, [')' thiskey ' '], [')' newline newLineBeforeKeywords{iNewLine} ' ']);
            linesToSplit = regexprep(linesToSplit, [')' thiskey '('], [')' newline newLineBeforeKeywords{iNewLine} '(']);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ';'], [',' newline newLineBeforeKeywords{iNewLine} ';']);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ';'], [newline newLineBeforeKeywords{iNewLine} ';']);
            if endsWith(linesToSplit, newLineBeforeKeywords{iNewLine}) 
                 linesToSplit = regexprep(linesToSplit, newLineBeforeKeywords{iNewLine}, [newline newLineBeforeKeywords{iNewLine}]);
            end
        end

       linesToSplit = split(linesToSplit, newline);
       
       if size(linesToSplit,1) > 1
           linesToSplit = linesToSplit(arrayfun(@(x) ~isempty(linesToSplit{x}), 1:size(linesToSplit,1)));
            for iNewLine = 1:size(linesToSplit,1)
                if iNewLine == 1
                    codeLines = [codeLines(1:iLine+iNewLine-1-1); linesToSplit{iNewLine}; codeLines(iLine+iNewLine:end)];
                else
                    codeLines = [codeLines(1:iLine+iNewLine-1-1); linesToSplit{iNewLine}; codeLines(iLine+iNewLine-1:end)];
                end
            end
       end
       linesToSplit = linesToSplit{1};
    end
    if contains(linesToSplit(1:end), newLineAfterKeywords)
        for iNewLine = 1:size(newLineAfterKeywords,2)
            thiskey = newLineAfterKeywords{iNewLine};
            % all possible combinations
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ' '], [' ' newLineAfterKeywords{iNewLine} newline]);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ' '], [' ' newLineAfterKeywords{iNewLine} newline]);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ' '], [',' newLineAfterKeywords{iNewLine} newline]);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ','], [',' newLineAfterKeywords{iNewLine} ',' newline]);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ','], [' ' newLineAfterKeywords{iNewLine} ',' newline]);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey '('], [' ' newLineAfterKeywords{iNewLine} newline]);
            linesToSplit = regexprep(linesToSplit, [',' thiskey '('], [',' newLineAfterKeywords{iNewLine} newline]);
            linesToSplit = regexprep(linesToSplit, [';' thiskey '('], [' ' newLineAfterKeywords{iNewLine} newline]);
            linesToSplit = regexprep(linesToSplit, [';' thiskey ','], [' ' newLineAfterKeywords{iNewLine} ',' newline]);
            linesToSplit = regexprep(linesToSplit, [';' thiskey ' '], [' ' newLineAfterKeywords{iNewLine} newline]);
            linesToSplit = regexprep(linesToSplit, [';' thiskey ';'], [' ' newLineAfterKeywords{iNewLine} ';' newline]);
            linesToSplit = regexprep(linesToSplit, [')' thiskey ';'], [')' newLineAfterKeywords{iNewLine} ';' newline]);
            linesToSplit = regexprep(linesToSplit, [')' thiskey ' '], [')' newLineAfterKeywords{iNewLine} ' ' newline]);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ';'], [',' newLineAfterKeywords{iNewLine} ';' newline]);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ';'], [' ' newLineAfterKeywords{iNewLine} ';' newline]);
            if endsWith(linesToSplit, newLineAfterKeywords{iNewLine})
                linesToSplit = regexprep(linesToSplit, newLineAfterKeywords{iNewLine}, [newLineAfterKeywords{iNewLine} newline]);
            end
        end
       linesToSplit = split(linesToSplit, newline);
      
       if size(linesToSplit,1) > 1
           linesToSplit = linesToSplit(arrayfun(@(x) ~isempty(linesToSplit{x}), 1:size(linesToSplit,1)));
           for iNewLine = 1:size(linesToSplit,1)
                if iNewLine == 1
                    codeLines = [codeLines(1:iLine+iNewLine-1-1); linesToSplit{iNewLine}; codeLines(iLine+iNewLine:end)];
                else
                    codeLines = [codeLines(1:iLine+iNewLine-1-1); linesToSplit{iNewLine}; codeLines(iLine+iNewLine-1:end)];
                end
           end
       end
       linesToSplit = linesToSplit{1};
    end
 finalSplit = ';';
        if contains(linesToSplit(2:end), finalSplit)
            thiskey = finalSplit;
            % all possible combinations
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ' '], [' ' finalSplit newline]);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ' '], [' ' finalSplit newline]);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ' '], [' ' finalSplit newline]);
            linesToSplit = regexprep(linesToSplit, [',' thiskey ','], [' ' finalSplit newline]);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey ','], [' ' finalSplit newline]);
            linesToSplit = regexprep(linesToSplit, [' ' thiskey '('], [' ' finalSplit newline]);
            linesToSplit = regexprep(linesToSplit, [',' thiskey '('], [' ' finalSplit newline]);
        end
       linesToSplit = split(linesToSplit, newline);
      
       if size(linesToSplit,1) > 1
           linesToSplit = linesToSplit(arrayfun(@(x) ~isempty(linesToSplit{x}), 1:size(linesToSplit,1)));
           for iNewLine = 1:size(linesToSplit,1)
                if iNewLine == 1
                    codeLines = [codeLines(1:iLine+iNewLine-1-1); linesToSplit{iNewLine}; codeLines(iLine+iNewLine:end)];
                else
                    codeLines = [codeLines(1:iLine+iNewLine-1-1); linesToSplit{iNewLine}; codeLines(iLine+iNewLine-1:end)];
                end
           end
       end
       linesToSplit = linesToSplit{1};
    


    splitLine = linesToSplit;
end