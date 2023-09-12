function diagnosticoSkin = TextureDiagnostic (edad,textura)

fuzzy_diagnostic = readfis('fuzzy_diag');
n_diag=evalfis(fuzzy_diagnostic,[edad textura]);
% diagnosticoSkin = n_diag;

if n_diag <= 20
    %%T_0
    diagnosticoSkin = 'You have a young and healthy skin';  
elseif n_diag > 20 && n_diag<=30,
    %%T_1
    diagnosticoSkin = 'Minimal skin wrinkling, Minimal pigmentary changes'; 
elseif n_diag >30 && n_diag<=40,
    diagnosticoSkin = 'Skin with expression wrinkles. Mild to moderate photoaging. Mild pigmentary changes. Beginning of the presence of wrinkles.';
elseif n_diag >40 && n_diag<=60,
    diagnosticoSkin = 'Skin with wrinkles at rest advanced photoaging. Presence of wrinkles. Visible pigmentary changes';
elseif n_diag > 60,
    diagnosticoSkin = 'Skin with severe photoaging wrinkles. Very wrinkled skin';
end

end