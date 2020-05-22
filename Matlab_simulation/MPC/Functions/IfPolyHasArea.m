function const_vect = IfPolyHasArea(const_vect, poly, poly_dim, pose, rob_diameter)
    closest_point = if_else(poly_dim == 3, Closest_point_2_Poly(poly(1:6), 3, pose), Closest_point_2_Poly(poly(1:8), 4, pose));   
%       closest_point = if_else(poly_dim == 3, Closest_point_2_Poly(poly(1:6), 3, pose), ...
%       if_else(poly_dim == 4, Closest_point_2_Poly(poly(1:8), 4, pose), ...
%       if_else(poly_dim == 5, Closest_point_2_Poly(poly(1:10), 5, pose), ...
%       Closest_point_2_Poly(poly(1:12), 6, pose))));
    const_vect = [const_vect; -sqrt((pose(1)-closest_point(1))^2+(pose(2)-closest_point(2))^2) + rob_diameter/2];
end

