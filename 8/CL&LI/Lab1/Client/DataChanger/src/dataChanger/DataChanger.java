package dataChanger;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.lang.reflect.GenericArrayType;
import java.util.ArrayList;
import java.util.EventObject;

import javax.swing.*;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.*;

/**
 * This program demonstrates cell rendering and editing in a table.
 */
public class DataChanger {
	public static void main(String[] args) {
		JFrame frame = new DataChangerFrame();
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}
}

/**
 * This frame contains a table of planet data.
 */
class DataChangerFrame extends JFrame {
	private JTable table;
	private DataTableModel model;
	private static final int DEFAULT_WIDTH = 600;
	private static final int DEFAULT_HEIGHT = 400;
	private static final long serialVersionUID = 8321496756978547519L;

	public DataChangerFrame() {
		setTitle("Data Changer");
		setLayout(new GridBagLayout());
		setSize(DEFAULT_WIDTH, DEFAULT_HEIGHT);

		model = new DataTableModel();
		table = new JTable(model);
		table.setRowHeight(20);
		table.setRowSelectionAllowed(false);

		//
		// table.addPropertyChangeListener(new PropertyChangeListener() {
		// @Override
		// public void propertyChange(PropertyChangeEvent arg0) {
		// if ((arg0.getPropertyName().equals("tableCellEditor"))
		// & (arg0.getOldValue() != null))
		// System.out.println((((Object) arg0.getOldValue())));
		// // TODO Auto-generated method stub
		// }
		// });

		JComboBox levelCombo = new JComboBox();
		for (int i = 1; i <= 10; i++)
			levelCombo.addItem(i);

		TableColumnModel columnModel = table.getColumnModel();
		TableColumn levelColumn = columnModel
				.getColumn(DataTableModel.LEVEL_COLUMN);
		levelColumn.setCellEditor(new DefaultCellEditor(levelCombo));

		table.getModel().addTableModelListener(new TableModelListener() {
			@Override
			public void tableChanged(TableModelEvent arg0) {
				System.out.println(arg0);
				int row = arg0.getFirstRow();
				int column = arg0.getColumn();
				String columnName = model.getColumnName(column);
				Object data = model.getValueAt(row, column);
				DBAdapter.modifyQuest(column, data, model.getValueAt(row, 0));
			}
		});

		TableColumn column = null;
		for (int i = 0; i < table.getColumnCount(); i++) {
			column = table.getColumnModel().getColumn(i);
			if (i == 0)
				column.setMaxWidth(20);
		}

		JButton loadButton = new JButton("Load");
		loadButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				model.load();
				table.revalidate();
				table.repaint();
			}
		});
		JButton addrowButton = new JButton("Add Row");
		addrowButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				model.addRow();
				table.revalidate();
				table.repaint();
			}
		});
		JButton deleterowButton = new JButton("Delete Row");
		deleterowButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				model.removeRow();
				table.revalidate();
				table.repaint();
			}
		});
		JButton deleteallButton = new JButton("Delete All");
		deleteallButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent event) {
				model.removeAll();
				table.revalidate();
				table.repaint();
			}
		});

		add(loadButton, new GridBagConstraints(0, 0, 1, 1, 1, 0,
				GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL,
				new Insets(0, 0, 0, 0), 0, 0));
		add(addrowButton, new GridBagConstraints(1, 0, 1, 1, 1, 0,
				GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL,
				new Insets(0, 0, 0, 0), 0, 0));
		add(deleterowButton, new GridBagConstraints(2, 0, 1, 1, 1, 0,
				GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL,
				new Insets(0, 0, 0, 0), 0, 0));
		add(deleteallButton, new GridBagConstraints(3, 0, 1, 1, 1, 0,
				GridBagConstraints.CENTER, GridBagConstraints.HORIZONTAL,
				new Insets(0, 0, 0, 0), 0, 0));
		add(new JScrollPane(table), new GridBagConstraints(0, 1, 4, 1, 1, 1,
				GridBagConstraints.CENTER, GridBagConstraints.BOTH, new Insets(
						0, 0, 0, 0), 0, 0));
	}
}

/**
 * The planet table model specifies the values, rendering and editing properties
 * for the planet data.
 */
class DataTableModel extends DefaultTableModel {
	public static final int ID_COLUMN = 0;
	public static final int TASK_COLUMN = 1;
	public static final int DESCRIPTION_COLUMN = 2;
	public static final int VARIANTS_COLUMN = 3;
	public static final int SOLVE_COLUMN = 4;
	public static final int LEVEL_COLUMN = 5;
	private ArrayList<Object[]> cells = new ArrayList<Object[]>();

	private String[] columnNames = { "ID", "Task", "Description", "Variants",
			"Solve", "Level" };

	public String getColumnName(int c) {
		return columnNames[c];
	}

	public Class getColumnClass(int c) {
		switch (c) {
		case ID_COLUMN:
			return Integer.class;
		case TASK_COLUMN:
			return String.class;
		case DESCRIPTION_COLUMN:
			return String.class;
		case VARIANTS_COLUMN:
			return String.class;
		case SOLVE_COLUMN:
			return String.class;
		case LEVEL_COLUMN:
			return Integer.class;
		default:
			return String.class;
		}
	}

	public int getColumnCount() {
		return 6;
	}

	public int getRowCount() {
		if (cells != null)
			return cells.size();
		else
			return 0;
	}

	public Object getValueAt(int r, int c) {
		return cells.get(r)[c];
	}

	public void setValueAt(Object obj, int r, int c) {
		Object[] mObj = cells.get(r);
		mObj[c] = obj;
		cells.set(r, mObj);
		fireTableCellUpdated(r, c);
	}

	public boolean isCellEditable(int r, int c) {
		return c == TASK_COLUMN || c == DESCRIPTION_COLUMN || c == SOLVE_COLUMN
				|| c == VARIANTS_COLUMN || c == LEVEL_COLUMN;
	}

	public void addRow() {
		if (DBAdapter.addQuest(new Object[] { cells.size() + 1, "PROGRAM_ING",
				"Insert missed letter", "M|V||", "PROGRAMMING", 5 })) {
			cells.add(new Object[] { cells.size() + 1, "PROGRAM_ING",
					"Insert missed letter", "M|V||", "PROGRAMMING", 5 });
		}

	}

	public void removeRow() {
		Object[] possibleValues = new Object[cells.size()];
		for (int i = 0; i < possibleValues.length; i++)
			possibleValues[i] = (i + 1);
		Object selectedValue = JOptionPane.showInputDialog(null,
				"Select a row to delet!", "Row Number",
				JOptionPane.INFORMATION_MESSAGE, null, possibleValues, null);
		if (selectedValue != null) {
			int rowNumber = Integer.parseInt(selectedValue.toString()) - 1;
			if (DBAdapter.removeQuest(cells.get(rowNumber))) {
				cells.remove(rowNumber);
			}
		}
	}

	public void removeAll() {
		if (DBAdapter.removeAll())
			cells.clear();
	}

	public void load() {
		ArrayList<Object[]> newCells;
		newCells = DBAdapter.loadDB();
		if (newCells != null) {
			cells.clear();
			cells.addAll(newCells);
		}
	}
}
