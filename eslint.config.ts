import ouuan from '@ouuan/eslint-config-ts';
import tseslint from 'typescript-eslint';

export default [
  ...ouuan,
  tseslint.configs.disableTypeChecked,
];
