function [pdbData] = duplicatePDB(fileName, nx,ny,nz, dx,dy,dz)

%%% recordName(m) = {thisLine(1:6)};
%%% atomNum(m)    = {thisLine(7:11)};
%%% atomName(m)   = {thisLine(13:16)};
%%% altLoc(m)     = {thisLine(17)};
%%% resName(m)    = {thisLine(18:20)};
%%% 
%%% chainID(m)    = {thisLine(22)};
%%% resNum(m)     = {thisLine(23:26)};
%%% X(m)          = {thisLine(31:38)};
%%% Y(m)          = {thisLine(39:46)};
%%% Z(m)          = {thisLine(47:54)};

%%% PDBdata.recordName = strtrim(recordName);
%%% PDBdata.atomNum    = str2double(atomNum);
%%% PDBdata.atomName   = strtrim(atomName);
%%% PDBdata.altLoc     = altLoc;
%%% PDBdata.resName    = strtrim(resName);
%%% 
%%% PDBdata.chainID    = chainID;
%%% PDBdata.resNum     = str2double(resNum);
%%% PDBdata.X          = str2double(X);
%%% PDBdata.Y          = str2double(Y);
%%% PDBdata.Z          = str2double(Z);
%%% 
%%% PDBdata.occupancy  = str2double(occupancy);
%%% PDBdata.betaFactor = str2double(betaFactor);
%%% PDBdata.element    = strtrim(element);
%%% PDBdata.charge     = strtrim(charge);

data = pdb2mat(fileName);
pdbData = data;
partAtomNum = length(data.recordName);
partResNum = max(data.resNum);
totalAtomNum = length(data.recordName) * nx * ny * nz;

for zz = 1:nz
	for yy = 1:ny
		for xx = 1:nx
			if(xx==1 && yy==1 && zz==1)
				continue;
			end
			pdbData.recordName  = [ pdbData.recordName data.recordName ];
			pdbData.atomNum     = [ pdbData.atomNum    data.atomNum + max(pdbData.atomNum) ];
			pdbData.atomName    = [ pdbData.atomName   data.atomName   ];
			pdbData.altLoc      = [ pdbData.altLoc     data.altLoc     ];
			pdbData.resName     = [ pdbData.resName    data.resName    ];
			pdbData.chainID     = [ pdbData.chainID    data.chainID    ];
			pdbData.resNum      = [ pdbData.resNum     data.resNum + max(pdbData.resNum)  ];
			pdbData.X           = [ pdbData.X        data.X + dx*(xx-1)];
			pdbData.Y           = [ pdbData.Y        data.Y + dy*(yy-1)];
			pdbData.Z           = [ pdbData.Z        data.Z + dz*(zz-1)];
			pdbData.occupancy   = [ pdbData.occupancy  data.occupancy  ];
			pdbData.betaFactor  = [ pdbData.betaFactor data.betaFactor ];
			pdbData.element     = [ pdbData.element    data.element    ];
			pdbData.charge      = [ pdbData.charge     data.charge     ];
		end
	end
end

pdbData.outfile = strcat(strread(data.outfile,'%s', 'delimiter', '.', 'whitespace',''){1},'-out.pdb');

end
