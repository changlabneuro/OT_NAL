%%  load

eyes = load( 'eye_roi_8_blocks_processed' );
image = load( 'image_roi_8_blocks_processed' );

fs = fieldnames( eyes );
eyes = eyes.(fs{1});
fs = fieldnames( image );
image = image.(fs{1});

image = image.to_container();
image = image.sparse();
eyes = eyes.to_container();
eyes = eyes.sparse();

eyes = eyes.add_field( 'rois', 'eyes' );
image = image.add_field( 'rois', 'image' );
combined = eyes.append( image );

%%  pre process

use = combined;
use = use.only( {'monkeys', 'people'} );
use = use.rm( 'block_1' );
use = use.keep( use.data ~= 0 );
% use = use.collapse( 'blocks' );

%%  normalize

normed = use;
norm_within = { 'monkeys', 'drugs', 'images', 'doses', 'rois' };
meaned = normed.do_per( norm_within, @mean );
sal = meaned.only( 'saline' );
[inds, combs] = normed.get_indices( norm_within );
dose_ind = strcmp( norm_within, 'doses' );
assert( any(dose_ind), 'Specify doses in `within`.' );
for i = 1:numel(inds)
  extr = normed.keep( inds{i} );
  matched_saline = sal.only( combs(i, ~dose_ind) );
  normed.data( inds{i} ) = normed.data( inds{i} ) ./ matched_saline.data;  
end

%%  plot
plt = normed.only( 'n' );

pl = ContainerPlotter();
pl = pl.default();

pl.y_lim = [.9 2.2];
pl.order_by = { 'saline', 'small', 'medium', 'large' };
pl.order_groups_by = { 'monkeys', 'people' };
pl.order_panels_by = { 'image', 'eyes' };
pl.plot_by( plt, 'doses', 'images', {'drugs', 'rois'} );

%%  save
to_save = normed.only( 'n' );
to_full = Structure();

func = @mean;

%   these are the plotted means

plotted = to_save;
plotted = plotted.do_per( {'drugs', 'doses', 'images', 'rois'}, func );
plotted = plotted.collapse( 'sessions' );

to_full.plotted = plotted;

%   these are the means per monkey

per_monk = to_save;
per_monk = per_monk.do_per( {'drugs', 'doses', 'images', 'rois', 'monkeys'}, func );
per_monk = per_monk.collapse( 'sessions' );

to_full.per_monk = per_monk;

%   these are the means per monkey, per session

per_session = to_save;
per_session = per_session.do_per( {'drugs', 'doses', 'images', 'rois', 'monkeys', 'sessions'}, func );
per_session = per_session.collapse( 'blocks' );
to_full.per_session = per_session;

%   format the means so that, rather than a column vector of values, they
%   are a matrix of values where the column dimension is doses, going from
%   saline -> large

to_full = to_full.each( @container_vec_to_mat, 'doses', {'saline', 'small', 'medium', 'large'} );
to_full = to_full.full();
to_full = to_full.struct();
%   convert to a normal struct
funced = to_full.objects;

cd ~/Desktop;


