/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Written (W) 2011 Baozeng Ding
 *
 */

/* One dimensional input arrays */
%define TYPEMAP_SGVECTOR(SGTYPE)

%typemap(typecheck, precedence=SWIG_TYPECHECK_POINTER) shogun::SGVector<SGTYPE> {
	if(!lua_istable(L, $input)) {
		luaL_typerror(L, $input, "vector");		
		$1 = 0;
	}
	else {
		$1 = 1;
		int numitems = 0;
		numitems = lua_objlen(L, $input);
		if(numitems == 0) {
			luaL_argerror(L, $input, "empty vector");
			$1 = 0;
		}
	}
}

%typemap(in) shogun::SGVector<SGTYPE> {
	SGTYPE *array;
	int32_t i, len;

	if (!lua_istable(L, $input)) {
		luaL_typerror(L, $input, "vector");
		return 0;
	}
	
	len = lua_objlen(L, $input);
	if (len == 0){
		luaL_argerror(L, $input, "empty vector");
		return 0;
	}
	
	array = new SGTYPE[len];
	for ( i = 0; i < len; i++) {
		lua_rawgeti(L, $input, i + 1);
		if (lua_isnumber(L, -1)){
			array[i] = (SGTYPE)lua_tonumber(L, -1);
		}
		else {
			lua_pop(L, 1);
			luaL_argerror(L, $input, "vector must contain numbers");
			delete [] array;
			return 0;
		}
		lua_pop(L,1);
	}

	$1 = shogun::SGVector<SGTYPE>((SGTYPE *)array, len);
}

%typemap(out) shogun::SGVector<SGTYPE> {
	int32_t i;
	int32_t len = $1.vlen;
	SGTYPE* vec = $1.vector;	

	lua_newtable(L);	
	for (i = 0; i < len; i++) {
		lua_pushnumber(L, (lua_Number)vec[i]);
		lua_rawseti(L, -2, i + 1);
	}
 	SWIG_arg++;
}
%enddef

/* Define concrete examples of the TYPEMAP_SGVECTOR macros */
TYPEMAP_SGVECTOR(uint8_t)
TYPEMAP_SGVECTOR(int32_t)
TYPEMAP_SGVECTOR(int16_t)
TYPEMAP_SGVECTOR(uint16_t)
TYPEMAP_SGVECTOR(float32_t)
TYPEMAP_SGVECTOR(float64_t)

#undef TYPEMAP_SGVECTOR

/* Two dimensional input/output arrays */
%define TYPEMAP_SGMATRIX(SGTYPE)

%typemap(typecheck, precedence=SWIG_TYPECHECK_POINTER) shogun::SGMatrix<SGTYPE>
{
   if(!lua_istable(L, $input)) {
		luaL_typerror(L, $input, "matrix");				
		$1 = 0;
	}
	else {
		$1 = 1;
		int rows = lua_objlen(L, $input);
		if(rows == 0) {
			luaL_argerror(L, $input, "empty matrix");
			$1 = 0;
		}
		else {
			lua_rawgeti(L, $input, 1);
			if (!lua_istable(L, -1)) {
				luaL_argerror(L, $input, "matrix row is not a table");
				$1 = 0;			
			}
			else {
				int cols = lua_objlen(L, -1);
				if (cols == 0) {
					luaL_argerror(L, $input, "matrix row appears to be empty");
					$1 = 0;
				}			
			}
			lua_pop(L, 1);
					
		}
	}
}

%typemap(in) shogun::SGMatrix<SGTYPE> {
	SGTYPE *array;
	int32_t i, j, rows, cols;

	if (!lua_istable(L, $input)) {
		return luaL_typerror(L, $input, "matrix");
	}

	rows = lua_objlen(L, $input);
	lua_rawgeti(L, $input, 1);
	cols = lua_objlen(L, -1);
	if (cols == 0) {
		return luaL_argerror(L, $input, "matrix row appears to be empty");	
	}
	lua_pop(L, 1);

	array = new SGTYPE[rows * cols];
	for (i = 0; i < rows; i++) {
		lua_rawgeti(L, $input, i + 1);
		if (!lua_istable(L, -1)) {
			delete [] array;
			return luaL_argerror(L, $input, "matrix row is not a table");
		}
		
		if (lua_objlen(L, -1) != cols)
			return luaL_argerror(L, $input, "matrix rows have inconsistent sizes");

		for (j = 0; j < cols; j++) {
			lua_rawgeti(L, -1, j + 1);
			if (!lua_isnumber(L, -1)) {
				delete [] array;
				return luaL_argerror(L, 1, "matrix must contain numbers");
			}
			
			array[i * cols + j] = (SGTYPE)lua_tonumber(L, -1);
			lua_pop(L, 1);
		}
		lua_pop(L, 1);
	}
	
	$1 = shogun::SGMatrix<SGTYPE>((SGTYPE*)array, rows, cols);
}

%typemap(out) shogun::SGMatrix<SGTYPE> {
	int32_t rows = $1.num_rows;
	int32_t cols = $1.num_cols;
	int32_t len = rows * cols;
	int32_t i, j;	
	
	lua_newtable(L);
		
	for (i = 0; i < rows; i++) {
		lua_newtable(L);
		for (j = 0; j < cols; j++) {
			lua_pushnumber(L, (lua_Number)$1.matrix[i * cols + j]);
			lua_rawseti(L, -2, j + 1);
		}
		lua_rawseti(L, -2, i + 1);
	}

	SWIG_arg++;
}

%enddef

/* Define concrete examples of the TYPEMAP_SGMATRIX macros */
TYPEMAP_SGMATRIX(uint8_t)
TYPEMAP_SGMATRIX(int32_t)
TYPEMAP_SGMATRIX(int16_t)
TYPEMAP_SGMATRIX(uint16_t)
TYPEMAP_SGMATRIX(float32_t)
TYPEMAP_SGMATRIX(float64_t)

#undef TYPEMAP_SGMATRIX

/* input/output typemap for CStringFeatures */
%define TYPEMAP_STRINGFEATURES(SGTYPE, TYPECODE)

%typemap(in) shogun::SGStringList<SGTYPE> {
	int32_t size = 0;
	int32_t i;
	int32_t len, max_len = 0;

	if (!lua_istable(L, $input)) {
		return luaL_typerror(L, $input, "stringList");
	}
	
	size = lua_objlen(L, $input);
	shogun::SGString<SGTYPE>* strings=new shogun::SGString<SGTYPE>[size];

	for (i = 0; i < size; i++) {
		lua_rawgeti(L, $input, i + 1);
		if (lua_isstring(L, -1)) {
			len = 0;				
			const char *str = lua_tolstring(L, -1, (size_t *)&len);
			max_len = shogun::CMath::max(len, max_len);

			strings[i].length = len;
			strings[i].string = NULL;
			
			if (len > 0) {			
				strings[i].string = new SGTYPE[len];
				memcpy(strings[i].string, str, len);
			}
		}
		else {
			if (!lua_istable(L, -1)) {
				return luaL_argerror(L, $input, "expected matrix ");
			}
			SGTYPE *arr = (SGTYPE *)lua_topointer(L, -1);
			len = lua_objlen(L, -1);
			max_len = shogun::CMath::max(len, max_len);

			strings[i].length=len;
          strings[i].string=NULL;
			
			if (len > 0) {
				strings[i].string = new SGTYPE[len];
				memcpy(strings[i].string, arr, len * sizeof(SGTYPE));
			}
			
		}
		lua_pop(L,1);
	}
	
	SGStringList<SGTYPE> sl;
	sl.strings = strings;
	sl.num_strings = size;
	sl.max_string_length = max_len;
	$1 = sl;
}

%typemap(out) shogun::SGStringList<SGTYPE> {
	shogun::SGString<SGTYPE>* str = $1.strings;
	int32_t i, j, num = $1.num_strings;
	
	lua_newtable(L);

	for (i = 0; i < num; i++) {
		if (TYPECODE == "String[]") {
			lua_pushstring(L, (char *)str[i].string);
			lua_rawseti(L, -2, i + 1);
		}
		else {
			SGTYPE* data = new SGTYPE[str[i].length];
			memcpy(data, str[i].string, str[i].length * sizeof(SGTYPE));
			
			lua_newtable(L);
			for (j = 0; j < str[i].length; j++) {
				lua_pushnumber(L, (lua_Number)data[j]);
				lua_rawseti(L, -2, j + 1);
			}
			lua_rawseti(L, -2, i + 1);
		}
		delete[] str[i].string;
	}
	delete[] str;
	SWIG_arg++;
}

%enddef

TYPEMAP_STRINGFEATURES(char, "String[]")
TYPEMAP_STRINGFEATURES(uint8_t, "uint8[][]")
TYPEMAP_STRINGFEATURES(int16_t, "int16[][]")
TYPEMAP_STRINGFEATURES(uint16_t, "uint[][]")
TYPEMAP_STRINGFEATURES(int32_t, "int32[][]")
TYPEMAP_STRINGFEATURES(float32_t, "float[][]")
TYPEMAP_STRINGFEATURES(float64_t, "double[][]")

#undef TYPEMAP_STRINGFEATURES
